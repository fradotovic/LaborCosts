PGDMP         .                 {            TBP    14.6    14.6 ]    W           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            X           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            Y           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            Z           1262    16418    TBP    DATABASE     d   CREATE DATABASE "TBP" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Croatian_Croatia.1250';
    DROP DATABASE "TBP";
                postgres    false            [           0    0    DATABASE "TBP"    ACL     '   GRANT ALL ON DATABASE "TBP" TO "Brko";
                   postgres    false    3418            �            1255    16774    check_employee_contract()    FUNCTION       CREATE FUNCTION public.check_employee_contract() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM contract WHERE employee = NEW.employee) THEN
        RAISE EXCEPTION 'Employee already has an active contract.';
    END IF;
    RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.check_employee_contract();
       public          postgres    false            �            1255    16758    check_employee_data()    FUNCTION       CREATE FUNCTION public.check_employee_data() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
BEGIN
    IF NEW.email !~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
        RAISE EXCEPTION 'Invalid email format';
    END IF;
    RETURN NEW;
END;
$_$;
 ,   DROP FUNCTION public.check_employee_data();
       public          postgres    false            �            1255    16776    check_employee_shift()    FUNCTION     9  CREATE FUNCTION public.check_employee_shift() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM shift WHERE employee = NEW.employee AND date_of_shift = NEW.date_of_shift) THEN
        RAISE EXCEPTION 'You already created shift with that date';
    END IF;
    RETURN NEW;
END;
$$;
 -   DROP FUNCTION public.check_employee_shift();
       public          postgres    false            �            1255    16756    check_monthly_payments()    FUNCTION       CREATE FUNCTION public.check_monthly_payments() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    payments_count INT;
BEGIN
    SELECT COUNT(*) INTO payments_count FROM paycheck WHERE employee = NEW.employee AND EXTRACT(MONTH FROM date_to) = EXTRACT(MONTH FROM NEW.date_to) AND EXTRACT(YEAR FROM date_to) = EXTRACT(YEAR FROM NEW.date_to) AND id <> NEW.id;
    IF payments_count > 0 THEN
        RAISE EXCEPTION 'User has already received their monthly payment for this month';
    END IF;
    RETURN NEW;
END;
$$;
 /   DROP FUNCTION public.check_monthly_payments();
       public          postgres    false            �            1255    16764    check_vacation_days()    FUNCTION     5  CREATE FUNCTION public.check_vacation_days() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    total_days INT;
BEGIN
    SELECT SUM(end_date - start_date + 1) INTO total_days FROM leave_managment WHERE employee = NEW.employee AND EXTRACT(YEAR FROM start_date) = EXTRACT(YEAR FROM NEW.start_date) AND mode_of_operation = 1 AND id <> NEW.id;
    IF new.mode_of_operation = 1 AND total_days + (NEW.end_date - NEW.start_date + 1) > 20 THEN
        RAISE EXCEPTION 'User cannot be on vacation he used his 20 days per year';
    END IF;
    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.check_vacation_days();
       public          postgres    false            �            1255    16760    check_vacation_days_overlap()    FUNCTION     �  CREATE FUNCTION public.check_vacation_days_overlap() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    total INT;
BEGIN
    SELECT COUNT(id) INTO total FROM leave_managment WHERE employee = NEW.employee 
		AND ((start_date <= NEW.start_date AND end_date >= NEW.start_date)
			 OR (start_date <= NEW.end_date AND end_date >= NEW.end_date))
		AND id <> NEW.id;
    IF total > 0 THEN
        RAISE EXCEPTION 'User cannot be on vacation on already used days';
    END IF;
    RETURN NEW;
END;
$$;
 4   DROP FUNCTION public.check_vacation_days_overlap();
       public          postgres    false            �            1255    16752    check_working_hours()    FUNCTION     i  CREATE FUNCTION public.check_working_hours() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    total_hours interval;
BEGIN
    SELECT '24:00:00'::interval - NEW.start_time + NEW.end_time INTO total_hours;
    IF total_hours <> '08:00:00'::interval THEN
        RAISE EXCEPTION 'Shift must be exactly 8 hours long';
    END IF;
    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.check_working_hours();
       public          postgres    false            �            1255    16612    prevent_underage_insert()    FUNCTION       CREATE FUNCTION public.prevent_underage_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   
    IF NEW.birth_date > (CURRENT_DATE - INTERVAL '18 years') THEN
        
        RAISE EXCEPTION 'Underage users are not allowed';
    END IF;

    
    RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.prevent_underage_insert();
       public          postgres    false            �            1259    16457    contract    TABLE     �   CREATE TABLE public.contract (
    id integer NOT NULL,
    employee integer NOT NULL,
    job_position integer NOT NULL,
    start_contract date NOT NULL,
    price_of_hour money NOT NULL,
    number_of_vacation_days integer NOT NULL
);
    DROP TABLE public.contract;
       public         heap    postgres    false            �            1259    16456    Contract_ID_Contract_seq    SEQUENCE     �   CREATE SEQUENCE public."Contract_ID_Contract_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public."Contract_ID_Contract_seq";
       public          postgres    false    216            \           0    0    Contract_ID_Contract_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public."Contract_ID_Contract_seq" OWNED BY public.contract.id;
          public          postgres    false    215            �            1259    16429    employee    TABLE     9  CREATE TABLE public.employee (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text NOT NULL,
    phone_number text NOT NULL,
    birth_date date NOT NULL,
    adress text NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    role integer NOT NULL
);
    DROP TABLE public.employee;
       public         heap    postgres    false            �            1259    16428    Employee_ID_Employee_seq    SEQUENCE     �   CREATE SEQUENCE public."Employee_ID_Employee_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public."Employee_ID_Employee_seq";
       public          postgres    false    212            ]           0    0    Employee_ID_Employee_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public."Employee_ID_Employee_seq" OWNED BY public.employee.id;
          public          postgres    false    211            �            1259    16448    job_position    TABLE     Z   CREATE TABLE public.job_position (
    id_job integer NOT NULL,
    name text NOT NULL
);
     DROP TABLE public.job_position;
       public         heap    postgres    false            �            1259    16447     Job_Position_ID_Job_Positiom_seq    SEQUENCE     �   CREATE SEQUENCE public."Job_Position_ID_Job_Positiom_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public."Job_Position_ID_Job_Positiom_seq";
       public          postgres    false    214            ^           0    0     Job_Position_ID_Job_Positiom_seq    SEQUENCE OWNED BY     ^   ALTER SEQUENCE public."Job_Position_ID_Job_Positiom_seq" OWNED BY public.job_position.id_job;
          public          postgres    false    213            �            1259    16483    leave_managment    TABLE     �   CREATE TABLE public.leave_managment (
    id integer NOT NULL,
    employee integer NOT NULL,
    mode_of_operation integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    reason text
);
 #   DROP TABLE public.leave_managment;
       public         heap    postgres    false            �            1259    16482 &   Leave_Managment_ID_Leave_Managment_seq    SEQUENCE     �   CREATE SEQUENCE public."Leave_Managment_ID_Leave_Managment_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public."Leave_Managment_ID_Leave_Managment_seq";
       public          postgres    false    220            _           0    0 &   Leave_Managment_ID_Leave_Managment_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public."Leave_Managment_ID_Leave_Managment_seq" OWNED BY public.leave_managment.id;
          public          postgres    false    219            �            1259    16474    mode_of_operation    TABLE     {   CREATE TABLE public.mode_of_operation (
    id integer NOT NULL,
    type text NOT NULL,
    payweight numeric NOT NULL
);
 %   DROP TABLE public.mode_of_operation;
       public         heap    postgres    false            �            1259    16473 *   Mode_of_Operation_ID_Mode_of_operation_seq    SEQUENCE     �   CREATE SEQUENCE public."Mode_of_Operation_ID_Mode_of_operation_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 C   DROP SEQUENCE public."Mode_of_Operation_ID_Mode_of_operation_seq";
       public          postgres    false    218            `           0    0 *   Mode_of_Operation_ID_Mode_of_operation_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public."Mode_of_Operation_ID_Mode_of_operation_seq" OWNED BY public.mode_of_operation.id;
          public          postgres    false    217            �            1259    16528    paycheck    TABLE     �  CREATE TABLE public.paycheck (
    id integer NOT NULL,
    employee integer NOT NULL,
    payment_date date NOT NULL,
    total_sick_leave_days integer NOT NULL,
    total_vacation_days integer NOT NULL,
    total_overtime_hours integer NOT NULL,
    total_hours integer NOT NULL,
    gross_salary money NOT NULL,
    date_from date NOT NULL,
    date_to date NOT NULL,
    contributions money NOT NULL,
    net_salary money NOT NULL
);
    DROP TABLE public.paycheck;
       public         heap    postgres    false            �            1259    16527    Paycheck_ID_paycheck_seq    SEQUENCE     �   CREATE SEQUENCE public."Paycheck_ID_paycheck_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public."Paycheck_ID_paycheck_seq";
       public          postgres    false    226            a           0    0    Paycheck_ID_paycheck_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE public."Paycheck_ID_paycheck_seq" OWNED BY public.paycheck.id;
          public          postgres    false    225            �            1259    16511    shift    TABLE     �   CREATE TABLE public.shift (
    id integer NOT NULL,
    employee integer NOT NULL,
    date_of_shift date NOT NULL,
    shift_type integer NOT NULL
);
    DROP TABLE public.shift;
       public         heap    postgres    false            �            1259    16510    Shift_ID_Shift_seq    SEQUENCE     �   CREATE SEQUENCE public."Shift_ID_Shift_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."Shift_ID_Shift_seq";
       public          postgres    false    224            b           0    0    Shift_ID_Shift_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Shift_ID_Shift_seq" OWNED BY public.shift.id;
          public          postgres    false    223            �            1259    16502 
   shift_type    TABLE     �   CREATE TABLE public.shift_type (
    id integer NOT NULL,
    type text NOT NULL,
    payweight numeric NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL
);
    DROP TABLE public.shift_type;
       public         heap    postgres    false            �            1259    16501    Shift_Type_ID_Shift_Type_seq    SEQUENCE     �   CREATE SEQUENCE public."Shift_Type_ID_Shift_Type_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public."Shift_Type_ID_Shift_Type_seq";
       public          postgres    false    222            c           0    0    Shift_Type_ID_Shift_Type_seq    SEQUENCE OWNED BY     T   ALTER SEQUENCE public."Shift_Type_ID_Shift_Type_seq" OWNED BY public.shift_type.id;
          public          postgres    false    221            �            1259    16420    type_of_role    TABLE     _   CREATE TABLE public.type_of_role (
    "ID_Role" integer NOT NULL,
    "Type" text NOT NULL
);
     DROP TABLE public.type_of_role;
       public         heap    postgres    false            �            1259    16419    Type_Of_Role_ID_Role_seq    SEQUENCE     �   CREATE SEQUENCE public."Type_Of_Role_ID_Role_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public."Type_Of_Role_ID_Role_seq";
       public          postgres    false    210            d           0    0    Type_Of_Role_ID_Role_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public."Type_Of_Role_ID_Role_seq" OWNED BY public.type_of_role."ID_Role";
          public          postgres    false    209            �           2604    16460    contract id    DEFAULT     u   ALTER TABLE ONLY public.contract ALTER COLUMN id SET DEFAULT nextval('public."Contract_ID_Contract_seq"'::regclass);
 :   ALTER TABLE public.contract ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    216    216            �           2604    16432    employee id    DEFAULT     u   ALTER TABLE ONLY public.employee ALTER COLUMN id SET DEFAULT nextval('public."Employee_ID_Employee_seq"'::regclass);
 :   ALTER TABLE public.employee ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    211    212            �           2604    16451    job_position id_job    DEFAULT     �   ALTER TABLE ONLY public.job_position ALTER COLUMN id_job SET DEFAULT nextval('public."Job_Position_ID_Job_Positiom_seq"'::regclass);
 B   ALTER TABLE public.job_position ALTER COLUMN id_job DROP DEFAULT;
       public          postgres    false    213    214    214            �           2604    16486    leave_managment id    DEFAULT     �   ALTER TABLE ONLY public.leave_managment ALTER COLUMN id SET DEFAULT nextval('public."Leave_Managment_ID_Leave_Managment_seq"'::regclass);
 A   ALTER TABLE public.leave_managment ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            �           2604    16477    mode_of_operation id    DEFAULT     �   ALTER TABLE ONLY public.mode_of_operation ALTER COLUMN id SET DEFAULT nextval('public."Mode_of_Operation_ID_Mode_of_operation_seq"'::regclass);
 C   ALTER TABLE public.mode_of_operation ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            �           2604    16531    paycheck id    DEFAULT     u   ALTER TABLE ONLY public.paycheck ALTER COLUMN id SET DEFAULT nextval('public."Paycheck_ID_paycheck_seq"'::regclass);
 :   ALTER TABLE public.paycheck ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    226    226            �           2604    16514    shift id    DEFAULT     l   ALTER TABLE ONLY public.shift ALTER COLUMN id SET DEFAULT nextval('public."Shift_ID_Shift_seq"'::regclass);
 7   ALTER TABLE public.shift ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    16505    shift_type id    DEFAULT     {   ALTER TABLE ONLY public.shift_type ALTER COLUMN id SET DEFAULT nextval('public."Shift_Type_ID_Shift_Type_seq"'::regclass);
 <   ALTER TABLE public.shift_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221    222            �           2604    16423    type_of_role ID_Role    DEFAULT     �   ALTER TABLE ONLY public.type_of_role ALTER COLUMN "ID_Role" SET DEFAULT nextval('public."Type_Of_Role_ID_Role_seq"'::regclass);
 E   ALTER TABLE public.type_of_role ALTER COLUMN "ID_Role" DROP DEFAULT;
       public          postgres    false    210    209    210            J          0    16457    contract 
   TABLE DATA           v   COPY public.contract (id, employee, job_position, start_contract, price_of_hour, number_of_vacation_days) FROM stdin;
    public          postgres    false    216   ]y       F          0    16429    employee 
   TABLE DATA           �   COPY public.employee (id, first_name, last_name, email, phone_number, birth_date, adress, username, password, role) FROM stdin;
    public          postgres    false    212   ��       H          0    16448    job_position 
   TABLE DATA           4   COPY public.job_position (id_job, name) FROM stdin;
    public          postgres    false    214   �j      N          0    16483    leave_managment 
   TABLE DATA           h   COPY public.leave_managment (id, employee, mode_of_operation, start_date, end_date, reason) FROM stdin;
    public          postgres    false    220   n      L          0    16474    mode_of_operation 
   TABLE DATA           @   COPY public.mode_of_operation (id, type, payweight) FROM stdin;
    public          postgres    false    218   ��      T          0    16528    paycheck 
   TABLE DATA           �   COPY public.paycheck (id, employee, payment_date, total_sick_leave_days, total_vacation_days, total_overtime_hours, total_hours, gross_salary, date_from, date_to, contributions, net_salary) FROM stdin;
    public          postgres    false    226   ϔ      R          0    16511    shift 
   TABLE DATA           H   COPY public.shift (id, employee, date_of_shift, shift_type) FROM stdin;
    public          postgres    false    224   #�      P          0    16502 
   shift_type 
   TABLE DATA           O   COPY public.shift_type (id, type, payweight, start_time, end_time) FROM stdin;
    public          postgres    false    222   `�      D          0    16420    type_of_role 
   TABLE DATA           9   COPY public.type_of_role ("ID_Role", "Type") FROM stdin;
    public          postgres    false    210   ��      e           0    0    Contract_ID_Contract_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."Contract_ID_Contract_seq"', 553, true);
          public          postgres    false    215            f           0    0    Employee_ID_Employee_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."Employee_ID_Employee_seq"', 1121, true);
          public          postgres    false    211            g           0    0     Job_Position_ID_Job_Positiom_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public."Job_Position_ID_Job_Positiom_seq"', 1053, true);
          public          postgres    false    213            h           0    0 &   Leave_Managment_ID_Leave_Managment_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public."Leave_Managment_ID_Leave_Managment_seq"', 587, true);
          public          postgres    false    219            i           0    0 *   Mode_of_Operation_ID_Mode_of_operation_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public."Mode_of_Operation_ID_Mode_of_operation_seq"', 2, true);
          public          postgres    false    217            j           0    0    Paycheck_ID_paycheck_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."Paycheck_ID_paycheck_seq"', 512, true);
          public          postgres    false    225            k           0    0    Shift_ID_Shift_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Shift_ID_Shift_seq"', 554, true);
          public          postgres    false    223            l           0    0    Shift_Type_ID_Shift_Type_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public."Shift_Type_ID_Shift_Type_seq"', 8, true);
          public          postgres    false    221            m           0    0    Type_Of_Role_ID_Role_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Type_Of_Role_ID_Role_seq"', 1, true);
          public          postgres    false    209            �           2606    16462    contract Contract_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "Contract_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.contract DROP CONSTRAINT "Contract_pkey";
       public            postgres    false    216            �           2606    16436    employee Employee_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.employee DROP CONSTRAINT "Employee_pkey";
       public            postgres    false    212            �           2606    16455    job_position Job_Position_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.job_position
    ADD CONSTRAINT "Job_Position_pkey" PRIMARY KEY (id_job);
 J   ALTER TABLE ONLY public.job_position DROP CONSTRAINT "Job_Position_pkey";
       public            postgres    false    214            �           2606    16490 $   leave_managment Leave_Managment_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.leave_managment
    ADD CONSTRAINT "Leave_Managment_pkey" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.leave_managment DROP CONSTRAINT "Leave_Managment_pkey";
       public            postgres    false    220            �           2606    16481 (   mode_of_operation Mode_of_Operation_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.mode_of_operation
    ADD CONSTRAINT "Mode_of_Operation_pkey" PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.mode_of_operation DROP CONSTRAINT "Mode_of_Operation_pkey";
       public            postgres    false    218            �           2606    16533    paycheck Paycheck_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.paycheck
    ADD CONSTRAINT "Paycheck_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.paycheck DROP CONSTRAINT "Paycheck_pkey";
       public            postgres    false    226            �           2606    16509    shift_type Shift_Type_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.shift_type
    ADD CONSTRAINT "Shift_Type_pkey" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.shift_type DROP CONSTRAINT "Shift_Type_pkey";
       public            postgres    false    222            �           2606    16516    shift Shift_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.shift
    ADD CONSTRAINT "Shift_pkey" PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.shift DROP CONSTRAINT "Shift_pkey";
       public            postgres    false    224            �           2606    16427    type_of_role Type_Of_Role_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.type_of_role
    ADD CONSTRAINT "Type_Of_Role_pkey" PRIMARY KEY ("ID_Role");
 J   ALTER TABLE ONLY public.type_of_role DROP CONSTRAINT "Type_Of_Role_pkey";
       public            postgres    false    210            �           2620    16613    employee check_age    TRIGGER     �   CREATE TRIGGER check_age BEFORE INSERT OR UPDATE ON public.employee FOR EACH ROW EXECUTE FUNCTION public.prevent_underage_insert();
 +   DROP TRIGGER check_age ON public.employee;
       public          postgres    false    242    212            �           2620    16775     contract check_employee_contract    TRIGGER     �   CREATE TRIGGER check_employee_contract BEFORE INSERT ON public.contract FOR EACH ROW EXECUTE FUNCTION public.check_employee_contract();
 9   DROP TRIGGER check_employee_contract ON public.contract;
       public          postgres    false    216    243            �           2620    16759    employee check_employee_data    TRIGGER     �   CREATE TRIGGER check_employee_data BEFORE INSERT OR UPDATE ON public.employee FOR EACH ROW EXECUTE FUNCTION public.check_employee_data();
 5   DROP TRIGGER check_employee_data ON public.employee;
       public          postgres    false    244    212            �           2620    16777    shift check_employee_shift    TRIGGER        CREATE TRIGGER check_employee_shift BEFORE INSERT ON public.shift FOR EACH ROW EXECUTE FUNCTION public.check_employee_shift();
 3   DROP TRIGGER check_employee_shift ON public.shift;
       public          postgres    false    224    227            �           2620    16757    paycheck check_monthly_payments    TRIGGER     �   CREATE TRIGGER check_monthly_payments BEFORE INSERT OR UPDATE ON public.paycheck FOR EACH ROW EXECUTE FUNCTION public.check_monthly_payments();
 8   DROP TRIGGER check_monthly_payments ON public.paycheck;
       public          postgres    false    241    226            �           2620    16765 #   leave_managment check_vacation_days    TRIGGER     �   CREATE TRIGGER check_vacation_days BEFORE INSERT OR UPDATE ON public.leave_managment FOR EACH ROW EXECUTE FUNCTION public.check_vacation_days();
 <   DROP TRIGGER check_vacation_days ON public.leave_managment;
       public          postgres    false    231    220            �           2620    16761 +   leave_managment check_vacation_days_overlap    TRIGGER     �   CREATE TRIGGER check_vacation_days_overlap BEFORE INSERT OR UPDATE ON public.leave_managment FOR EACH ROW EXECUTE FUNCTION public.check_vacation_days_overlap();
 D   DROP TRIGGER check_vacation_days_overlap ON public.leave_managment;
       public          postgres    false    220    245            �           2620    16753    shift_type check_working_hours    TRIGGER     �   CREATE TRIGGER check_working_hours BEFORE INSERT OR UPDATE ON public.shift_type FOR EACH ROW EXECUTE FUNCTION public.check_working_hours();
 7   DROP TRIGGER check_working_hours ON public.shift_type;
       public          postgres    false    222    240            �           2606    16463    contract FK1_Employee    FK CONSTRAINT     z   ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "FK1_Employee" FOREIGN KEY (employee) REFERENCES public.employee(id);
 A   ALTER TABLE ONLY public.contract DROP CONSTRAINT "FK1_Employee";
       public          postgres    false    212    3225    216            �           2606    16491    leave_managment FK1_Employee    FK CONSTRAINT     �   ALTER TABLE ONLY public.leave_managment
    ADD CONSTRAINT "FK1_Employee" FOREIGN KEY (employee) REFERENCES public.employee(id);
 H   ALTER TABLE ONLY public.leave_managment DROP CONSTRAINT "FK1_Employee";
       public          postgres    false    212    3225    220            �           2606    16517    shift FK1_Employee    FK CONSTRAINT     w   ALTER TABLE ONLY public.shift
    ADD CONSTRAINT "FK1_Employee" FOREIGN KEY (employee) REFERENCES public.employee(id);
 >   ALTER TABLE ONLY public.shift DROP CONSTRAINT "FK1_Employee";
       public          postgres    false    224    3225    212            �           2606    16534    paycheck FK1_Employee    FK CONSTRAINT     z   ALTER TABLE ONLY public.paycheck
    ADD CONSTRAINT "FK1_Employee" FOREIGN KEY (employee) REFERENCES public.employee(id);
 A   ALTER TABLE ONLY public.paycheck DROP CONSTRAINT "FK1_Employee";
       public          postgres    false    212    3225    226            �           2606    16442    employee FK1_Type_Of_Role    FK CONSTRAINT     �   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT "FK1_Type_Of_Role" FOREIGN KEY (role) REFERENCES public.type_of_role("ID_Role") NOT VALID;
 E   ALTER TABLE ONLY public.employee DROP CONSTRAINT "FK1_Type_Of_Role";
       public          postgres    false    212    3223    210            �           2606    16468    contract FK2_Job_Position    FK CONSTRAINT     �   ALTER TABLE ONLY public.contract
    ADD CONSTRAINT "FK2_Job_Position" FOREIGN KEY (job_position) REFERENCES public.job_position(id_job) NOT VALID;
 E   ALTER TABLE ONLY public.contract DROP CONSTRAINT "FK2_Job_Position";
       public          postgres    false    214    3227    216            �           2606    16496 %   leave_managment FK2_Mode_of_Operation    FK CONSTRAINT     �   ALTER TABLE ONLY public.leave_managment
    ADD CONSTRAINT "FK2_Mode_of_Operation" FOREIGN KEY (mode_of_operation) REFERENCES public.mode_of_operation(id);
 Q   ALTER TABLE ONLY public.leave_managment DROP CONSTRAINT "FK2_Mode_of_Operation";
       public          postgres    false    220    3231    218            �           2606    16522    shift FK2_Shift_Type    FK CONSTRAINT     }   ALTER TABLE ONLY public.shift
    ADD CONSTRAINT "FK2_Shift_Type" FOREIGN KEY (shift_type) REFERENCES public.shift_type(id);
 @   ALTER TABLE ONLY public.shift DROP CONSTRAINT "FK2_Shift_Type";
       public          postgres    false    224    3235    222                       826    16614    DEFAULT PRIVILEGES FOR TABLES    DEFAULT ACL     K   ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES  TO PUBLIC;
                   postgres    false            J      x�e�K�����S� S�w���/��$Հ*bS-�D� �����g=%����OYOo���������'������O?	�[�?)�婒矜� m�^�����Z?i������n���� I*��y>}��lx�O���gt{㏄��ƿ�{@��3�2��f]�%=#�~����������g�Ӟ�[@[�3*o�ً����Z���h�#���r�-�f�j���k ۔�3'��A�|h��1��c/�n�*^a���١=�^/ ����ǲC��8�C�n���3�
��tc�N��6B��Q�E!�d�f�y��v�AO�[oz�r/���'�b��滍���L�N��������3�,�H���oj+�������!͵<��p`h�Hs��l�h|�L�t-���|���a&@�n���q�����d���>�g��|�c&g*���?y�Mf��{Kv����P��w`l0��>��ɵ���tI�T1?������L�ز��Wl�8�4�MA��_/?���if��z���5��w{�,&`W8���:="@��B˦,޼��9��q�O>�a���g�<
=�� ǰ��n8��^6x�g�9KX�gB��)|� \$=��0g�D�����g����1�ʃ`^L����:�����Sd�;��S�>� ��O/�ލ�B,������an�/�np�m�T�9��\�In���[�h�����k��y Wq��{#�`�+���%��8A�ްpxT����k���� �^kϢ�j�S���|`�}��4Cع���Ɇ�2��H����9;14z;1�b^Y���kN碐憀��fBv�5X�5t�����ɿ)-q8-�(��@m���r"���]/)�p7F�,�c������m9i�k0����_�Y��lLm��qbb8
���9��Z|?!��cM�G�'��<OiYy���B�̀�Ą�4gps[�^>��Z��X@u&är�ѻ���愘TO��4�^�	��!���0	�����dR?c��J=<	����K}`��/MN$If�|֘�	.-�R�dRh���:��{Z��1�P>�BT�Qk�	.��c�4wJ�c>���<�� �bȯT��y�8	
p��������E�=�O��bYc���|\��o1K�o�ק�/>l�Ώ�P?E�7n��3�Ϟ"l)E��֙�[�����K��&6Uv�Mpy���\�|�� ��8[��J���^"m�ug k�	./���b(�6���̺��T��<[��Z$X��z�`�5�.\ÃxI���m�+܅A~�Q/�rL} �<oa��#"#��*M/N��]�1�@Uq�V9+܅�)�A�@ �;4��ł�ҹ0�����vhbrC2-��-��\1��LΩ|�Z�5��N����ԗ$��X�g����$HP����.Ii^n��0�*�����+ɕ�Eڃ!v�&�+�k�X�	�mj%���t�ᕈ	J�ZV4[Z�P�|��N�f���g�t�{rEHa&�J�a�-?}ʧ�d��K`��u�J�jBL�Du���Z�tK�9��}�r�����Y�]	u�r!�7�%+��9͐����9]8�jX��<+��k�-��<RN������͵���$o~^���K9I��tx�쇊U��$�U�.�
�RN�7���od��I�F`�g�����$y�X.��ʜ�RN�?95�ե�������?f��*���m8
~�����;9Oc�2O�7"�U`HQ�W%y� �ѐ�.����P�F~5y=9�\k�����R��I&�/6��i�	
k;<�z(�v��u��� 6�����C����7���P �H'�'�.�����1縄ml"4�5R�o��t,�(�g(�/M��G�yi��?�Q!�R��J�ZY�����V]�S��������At��ԥV�d8���˶~X�BV��f�K?�p�n�a�v����'�����E6[��p��E���D7���n�	A��C�-[�1��(���ӂ~	=��U�~n�.�����-n�
�P�<,X�f�|�õ�8�p��%�o��-���a�Kulb�*`�&�<�e\�FP�q`�IA�a?�L=,�Ĵ�YT�q`�,��8�X�+(7˯Jh�����3[���b�)XP)�J-���*�,(���zX��i�X?WL=+ج4�[�	.O������.󐂙��9C\�"�W�;.��NE
w�'
�=��@A�����1T��	��u���L�(���o���'X�uBp��'�-��hB\^��u�b��6���	Z��_�I�:�`K��p�	����~�mp}��l,W�.�
板b���8��9��'X��J!%�~P���ʜ�
J��^��,)/[����U�[x.o��&K#��D�>�p�;�a�&��
7\qC�;�el����Bq}�ފY�y��$R�++�{�@]�@A^c�2�Vk����&�;�5	^n�!��p�r�u=QS^���Cq��(���v�B��(X Ib�p��6"�
�-R�m��I�`uv2}����
�q/�?��	w?��o���Y����YLo�k���m��J���|9A�'>o�k&(�0ʆ�7�5_Lx�K�W�����u^�����Y��=�����u�/$hx}6�;�OE	�X�+CP��A��L���ou-�Ub0J~G��Z.$�Ulކ����BB�y� ⫍��r)AU���\J�㲧_R^�0�-����Gy-,��&ק7�p9�`�߸2N���!q��ڥ�	�Z(�[�8LK�k=�`Ӊ���{Mu�ў�}[c�lϤ2����V����CԵ
4+7!,�ԵP8kwVY�]`�*P�u��wa��Z
Z?�;�������	)�S7����	�z�ٞ��(X�5�@ym�i�z����M��@S�I�7'�ۆQ�<�y�0AT�\�ԵJ��d%5_���6Q��"Z�����P��eڼoĠ"H�F�-��b� �.3�_?�P킄[��q�Ou�b�[`a��O�}�������$����m,����C	g���
��E	*��>�$ԵH���lֆ���y �ҁ�S�<��8�p�����wC_�����j{@�N�%�߹����	�f~>P^�(A��6�Jx���	�҈I��&�] ���P^�(!��6�>�	�|l��I��'(����:'������ �S�������Fy�,��lSh��S�p_q�ۿ�-�'����z�5#N�r�2y�����	O��3܅{݇Nw�F/��S��ጫ��<�`�ζ��)�u��5f�0�P�u8�J�ƕ�����p�Y��=?ؐ�%P�L�,=�Q^�ᄳ�A����'�*��{�A^����%����.q�X�+�����'(���5؆��	w��ׄ�)�-N��0t'���	:i�(C���
�ζ��y݇n$IqS��
�f�gK}�";�d��P^�!CT�.�C��[�pK�t�n��[�p7�`�l��[�����(yK��n�!��-T��c�i�c�[+��s9���oI���e��x$�th!Y��#��R�ҡ�˺9P5�-Z�I5�Vo5�F�p�|�pf	�.87�����%��=��6a�A޲pA'�&[�-�[/�y���y���B����!o������$�oA����sX��uC�8���Xp�)o����6cǐy�n���uf���O@޲�Alnu������,����pA�T���Yu+��%����da9q��з"^0�Ά!�AފpAhhu�� oE�p3�}Box�L�pO���}	��VD�H��ͯI�nE���f�]=<.��[���_AݪXAdش����U��NPZ��c�[,���y�;y������$��'��D:��X<
Nu��{�l%���P�*Zx��Px��U��}%;S�7��)Z��[�60p-h�&��aB� �)VA���w���no=�[.��d�xX��Ď:�2 E  �b�W��Ղ�£`�&^P�_$�b��5��fO&Qݚp�=��>��ք�(Z�N��Ce��a��01O���c~R���}桾�@u��%���Lխ�TF�,�`�.X�b��@Ou�E���*�,�Ew4�d��.X�G�n�&����
-�5��b�.׆T�!VPo�a�'�V�p���%�nC�pW
��p�S����v�;,�(oC����Ht���!T�{�o����­����*(bMqh��C��Z�λ�ІQ������E8��'Vx��}��+�(E���m
�2��K0�M�»C�]��)T���`���T�)Tо�U�|��M����gq�7�%�B������M��[��,o(oS�p����$���XA�xV���Cu[B���oj(oK���bt�']��"B��빦�i��]եO���
���Q��/����Є3���?B�	./�������G��%X������m��2^�K��+�D�9rIy�b�ӯ�L}ۂ�����}o*ϋ�a@�J�7M�V��bl�y�T�3E���XТ�m��=D�/��[���j8�@uۂ���O�gT�b�(��O�{+�Qm1���T�$T�����.�=���Y��փ�'���$��kY�{+���@-��$XP�ɖ;DOyOb�{dn<Ꞅ
�+!����*E
�
�PC�)(Z�' �{)�2I��H��Y���B_��Y�pkLx��\PݳH�������Y�p�ƶ7Ó`�,R�a�����E
�m[��y�H�p�I��	���,T��?K0E��u����"Xx�3�6��O:���7h���{����?��Qދ`��Z��PދX�'wh���Y�c�/)�E���yV9Ə&��n�B�|-��^�
�`�}��y�b����
'�(�U�p{�?���*V�_N��}��U���w�uD��^Ew�ǶB�a�*X�;�<��b�8�`����wQ�{+���8&�b�b����\
&�t~�Ayob�Ԧ o���^���v���i�(�`��+�yyo���m��&0p+���Kdo�{+�="Vg��Bޛ`AQ�v�B��7������E�{,�!i�]d�{-���.N&��.Z�;���(�{,ܘϭE?R�eH�»������E�3:��v�? X3��%8(Խ����`���
,�-�������E��da�'����4�pn��/�K;d��1)�C�p-G�]�קּxA�;�a����T�»a�Q݇h�ݏޟ=৥C������ �}���=�|�My�M�m�V���pA��_Kk��.�ߎ�X��O��=v���Qާx�~��)�v;++^�ef��}g��S����~�¿5�����Mk��.ܪ�e��$\��w��ĭ�n�]!`Pv٬Us�4�ڳZ�O�V��$^��������/h[a�����tt�4~�å�/����w;�꾄����J�۸��{V���j��-܏q���+Aޗp�|���ws�s	�r"����DZ��� ��-�5�S�}�.)py&?h����Hx�k��j���}^�فJ(�[�p708��0T~�,Z����գ�oтj�v&Ňs��-�Ŭ��Kxo~#)\PI�j�;t�?�"Z�ۆ\}�0e��6��KT�$X�_�3^�&�h^�ps��ؼ�@>�`A�a;�-4!��749�
�#	\A!N]�G,��V	��X�,��S��z$��:cY7�ꑄ
��On��P����5����
�ns_�P>�XAe�f+k�a�a ����������ڧ����ϟ�˛�      F      x�l}Gw���Wh�F�E�3:�=c�D�Af�,��W� Rr�]w�]�� U�"�o��m��{��Q)���"���,�#�i8�t\a�<0�i
ӷ��aU��i�f;���l7^�~���ה���G��M���͢���(
n�Y��?I]
#�=�q�Et��<0���Q��Ө���(�P՘�3�Y^�+��uW��DL��u�Ϝ����
�Y�90���aN��,��"���aQd��轞�?K����E�:{��6��0<3�4�G?�<�|�K�2&Ѧȫ�䥡�~�����6j��8l��(�����܃�vL��i�yC
I���g�m�����g��*�hE�&�Fͬ�D�;�?ڐ��ǲ�M]y`�4RX��˳�U_%]^W�Xs�g���oΣ�>P��d}��oOv��ò/�|Uly:��h\��9|������'Y�eM�M��7�KD$������]As��&o�KD}ꂺ1z{k�I"8���U�-�����j�����i��$[kb����s�O�h��4��	:~���q^�=�}����8��`X�/�;���%}�8oR�+�v�u��48���͗u!�2ܠ�ƈ2�A�D�l�dm�ә�w�;>]C��t�G�i{��.���������s�4˒�iZ�UK6�t/
�*�x
�V���e9>}#�D_�ot���t�6t�v�E7����/���S��[q��Q�
:�h㰊p��b�ճ&Z��'�蓙�<p\�ƚLLh��l{�E4�sQ�U7R����л�s�	�Iq�'�¦�Ҽ�D�^B˪���ށM���=\����#�bZ��ӧ��$��/�U�{<�#�����E*β�؊f��.T]ϊ��3_
�#.`���GX���ղ�59ɊhC�lr\�M7�/�:���4.��*�3��fӚ�o�ҽi�ɢn�5�"הN����,>y���s2/�4+�jr�g�#!N��Wi��<q�mN�"�鶉e�:�p�ei�㮨�k3�6�\_(�yM��'�t�[����bQ}��ǧ'�x]��9q��,�W��d�:���'J���- ����k1�����Qo�y�酌��sf���7���>m2qUEN��B��������k�'t�l�Κ�M#>M7��K�혮Y�U��>Z�;&~������f�q\DMTѽ�&&T�˭H��������|�m��s�0w���dU���CG�m���6������l�CI���E&tXZ�]�N�u]M�>�/�,���83@[�����$򚌘�8\<���3��:��aC?"��hN�ሯ
y�Ky ��2��E�Ę<�]��t[����U5������_}��K�h��[�N͒��x�$҂��I<�9����s�m��ÃE�>�s�M�-}�J�o�qlK�T�;,�m���4��6�ĭ}�ԑÞ��#�a�&�J?�����wpf>8]qd�^G���n[����ג~�O��%Y��5�7�n��M.��?=˼a�8ͮ��/|9��ۨ�[Q�hX`8�EL_�o��o��M�L\_��CC���#FWӅ/�_�rQ�: ��Uے�/���ځ0���6�$-q����Sџ�$	ֹ�)����K���n�D��?D�$�ȋ�I��G��h҅�_'���n��l����#��Z C�?,����!g9�C��J�=i���Z�ݞ�ȴL�?		�D!�D���.������ ��<v����+N��Y_$|�H�C�	s�9�Qu?|^♆�`���a溾kN��t��D2l������������&��*�VD4�����Q�������2�#F� ��b�$�OK��r@g�����ǥ�$M�,Bg�ѢǱ%��@�-^���+A-]�:f�Y)�� �Z�Ɉ�z������'�4��q�8<Y�A�t5�q��`�S�z5s=�k��m~����9���恔N�D-	+��=9#<���89uH���hϿ����q����QY��Ȑ�U���?�D�"Ff��=4>������oy�� ��e���g+���a�qAҼ�M�6��7\-�<�$�3��!�2ZA6.g$!N/�.d5q�giTd4�9	�Q�['l�=��T�~צm#pg�����[d�PW_B޲
�	��v��ª�.M�-_YLp����U�4�B������Y,�%�E"�>m��u6��L�ꦛ�5�8Z̏��|�fu�VC<DuA�bFsE���B\Ѭ�D]2�
�y`�$�K�]�
��vXE�UE@D��0�p�\��T�m�"����[�u6}x��4�TP���V%-��b�V�6ش�7�<�E(8�::�Q��1��N@R6����u�����^E \RV	�5��=�б6?��O֋���Mg ;&��8+�rK6U�(l�4��l_2(���X��)�L�t��(�w������TՑ����F}�^iT��$q�"�����Tm IR�}ž���CG��_�M��&!�-�n_ߧɋ�솤�i�m瑸o�Vdth�$$-��sB_�9�H�z�o��	q��&�t��q�:��U˄]q�vM�C
媛��sDT�4$�(�I�n�Y���t!�e��,�:Y����f���o�'o��pz�7}
�HM�a=:y�Ru���./3\`pI���J�cGl��_XFU���F2�<�_$���F_\.3qD��%ܔǪ3s�ލ�?t�<� p]�r!p�n0�����N������U"�߾�6<O@���iNY�ǜ~wf�7��B+�t � ��64�t������\!�q�8���'������Hh� $�$��\g�/MڗQ���<�V+��	0mI��7<K�� ��"1qRz'Ȣh���.�Z��<da��#$P�D9E�����yg��������_M���m�����L�|6�N���<;��g]٢�C��59-�.��p���u� ��|�:pL�5� �f&ӅL�"���n<��:���s�E_	>C��1ҤZn�a'U�Q_�!=�1hLS!N���iHV��#�]�����]_���G<�MJf�M"$�1{���aJ�������+=-�$aVò��vrO��b����$�4q_���gHk�+I
��}�-4�\�@�hK�M+�m��U6�8�n�~�q��������9,x�|�Wa[��^a@O7I�q�A�RI�ݟ\��7��:���㺿��y�*" ��-}�E����O��kK:gt]�k��т-͞���?���hbۦ}zɫ�!�f,���v^f��Ǎ�A���*��,��2{.o��L���]g�"�3���E`q���l����aB(D���p5_���8����d�����n* �w� }�5�~����]K���㪞W��X��E����iu`���K�,p��0�4{��e����7����܊g2iM?�!GE��HcnېZu�=��2 ��I��.�eM���J�0P_����e�\`�l,g� �8&���pۅS��Kŷ-�0�:w+1�z��UC۶�I�S|G������o�1ہlI���bB��TЫ��ê��>�O���h��<Cs7�ȶ&gMVք����ŋw$?N^O��/���y�-�=E9T^�6��[�i]k�#}{@İ�ƹ�e��h˟G�KF�dq~�5-�G<�q���>������$��	�6��4R8�vI��;���
&����k.��ok��s��� y$��W �l������S%<�6i��4mے����$��S��w-��8�^W�)O�.o7P��s��Q�f��?�!zl��'�D`ҹ���e�C�ak'�x��v�F���Z����m�Z<�O�f:! ׉i��7����!�D7����N���ф]2&'�:os��)5O��y͙5�r�X�$���2�Aow�0�'��1ax�|m�W~�@�{�@��\���`qz�Я�4�a>�`�[�|��g�k�5Ͱ'AC����`�pڼ���0|}���L�q�(j�~f;�CJl�G)n���J�I���Ƥ��/T���$    �ث�p^6!We6���M��7F�'Y�򐖼!ƈƔ�v��l�s�$j߄?��E|�����E�u���<^]7'��$2�s�%����@���|��]I~>d����PBA�x�n�����}��_����MIR�yɭ鄛|�+C�O����G:���N�kҮ�s F�]����¼O_y=��y�"���<�NsBAe2���6�����}%����K[�m�'+ ����*�[��g�Oo���ly]�8�I��I�Ȳ�`6&���7���˵��t�F��Bi�I�%nP��?�i��/��S���=��ST���J���E�А�t@@�T���W؁Bc��y_�Y7��-^.���"���;�8$��[JR ��Y����Y�l�����GN2pA{r\߳�����4Z%[�,��mJB���YUkۡkFaFGW�\�M�t��oik@��M���2�$��xq���/_�$�^����.]M�id�a-�h� �X,���Q�aI�U�?� ԼB��7������_�5��g���t�� ����g&aҒl�i�jBⰁO���㟏��O^�X���=b�mO?��9c K��(�����!v,�L��4L�fV'5]�x^�f�VG��aK��� K�%'��b@d{��Ѷ�|c#�+����I��W��V$�1���׫�U�N#qx.�<m)"���r�~U��΍��"N�����w2��U�QA��\��F	Ŏz�4���EM�2TQ \����Z��LH�&OyFW�l���N���q~���e��n ƹ�[sҲ�L���J[�5�҇
�K���P�q-.���y��JR'�2o�Ո�H�$Tǜ��Sc��	s8�Pkp�3&'����2��syx�pz˳y0�G��u�l3�~���5�0������:)����� ��TJBM��99�H|u�C�OG�-�G�MwΎ�4�mJ��69��,#e�p�\��Ř��t�1x�|�qR�'��qB�э�GE��`���G��}�w@��׍�̹5�Gnl��B��Q����"е;*�lr�kk��#��/n~�?��g�D2���!�V��",��w���]h�w`��A`hrٖ �,���J��Q����y�}�0���f�%�B��Ӊ;fF+B�����>	8��/�1��+�^�n�Ȣr���l����k�Uttg���Y�Q!	�h�f� �@�iMnr5�h������]�����x�x�[R_Hy�Xt��f�~!0埊�9�@��;p}�����t�5A�5��綱?��h��l6.-��̖�8��Y��>��$���e�t8�.	3��W�g,�����5]F'�9�HA�w�7��;��ї/HW)�*������h0j�%A_ZR�8֊,�4�գy/�������#[P=8�ְ�"��G4t�&�R�H��J�6@����*O����#�8IC*��a��ĕ�o�;���\ �"Ǖ&dG`$���=��7��tɠNx��!��v5�B�Je�/��������Gg���y��iVܚ}H�'kְ�);;���q�i?�^��
��!-�͑�h�kys��]g�$���oҼӘ[sv�U��Re�4�XN��j�l\�c���I_1"Qr� �ʍe���"X�d[>�cD1�I>�57a�q�m��=��o�4�6�������}b�]}>�߬�yY�8-ژ�)�M
{d�T�'l�!v�{����Vlw�^}��P7��Փ͚��3	��Q��R4�6�$y�*�3|��������>ן�Ě�7�D�`=����_���y-޳-l�ب��n�2_��q =>[S�yp�&Bu����/hcGA�O�\w~��39���.��E���M�:��q�T��G���?�!�H��Sxu4�ލI{W�=߮�#�(���6l'�Xu,�?~h��/�����"�&݉�[i#䎊菏.���Eѝ�Q�@���&j��ZV8�jӒj"�? ��63�Ś�O��KT����,4�'f��w��A��I��aq4��ψ��r�:��k��T�������$6<�"Pޠ#op��"�sc{�,�k��>�c��J��u�dĚ�g�g9!�o��ѭ��#�a�,Bv�@�|���a����/.�/��,�i'���T�c��0�H���A ��Ė�7sUC��ۍi{�/�NC���_��"Ɖ�-/�ʈd0\�@��k5d0^U+�L�|��Ec��~��${#��3B����r�凄? 3��-v�X��p����e��+!�q�=*by���7{�6�����Ҝ��-	�n�{��C�
�<�I�l�g_u ;��*��`OZ�R�IZF�J	�}
�$>Ϋ��E:�z�7�<XZ𳢰n�D;��	��X�Rw��"�3Hf�\ٻ�܁�x����V�=�i=A܊~<a܎N� 8EǊ	&M]���G�2����C��I�>W��1j#��q��oc�l� �T�*�AE��$�T�"39�M�ֶ�K���$�ǘ\��o���,���iu��͍�s�����lC�k���ҽ����,�%sp������`E�y�Yj�1��[^���e�.�9�!�V��S4V����0��"�teÄ͘v�/v���8~xJ���
no�g�-��)C�םX��ZӰ�
��Yq�8qxK�|}:�TעC��`��Yɻ���XB��7u�X��i�T���֚�|?�8GA"���q�p�#���{�𚷢�)H���h`���
�6�֚�E_�BX aD�BX�-�vh�2�Ɓ½|>,����SH��1�M�K�a-�+ݳ�0��u[+E��s>n	o��$���)^/�����n8�߀��ҧ�0���W��m�\��F����4>\�� ��nҬȣ=N���F�.eā��:�h=$yӘ[k��6�-�����'b܆�{�p����HA�ʷ�<~._y&��6[�H5���[�`��C�C)$�����:'�L[ZYǓ0��O߼aL��F9�I�_&�R��2\�uY(�,���%w��P$��8/����`񾽺^T��_�7�x.2��[ձ����w�jϋ��P��IR�!N���N.�B�����A�)���U�i4#G*�L�Sb211�k���2L��U�=�jMC�g�7k�:�]�^bflpJ��V���FS���90����헣1��3�Y��Q�ZL���Hk:���QԎ}�{<�m��Hi�QT��D-%}6�:;6󇈨_���g�Y��n��/�Bdӎ[���Dƕ	t����<R��`��i4�	���|�xy	�p�w�C�)�尝�)4�1X7r�g�����]�|�"b�}|Tf?��;Q;is��8�g���r�:V�	!�$c����p�9�iG2�)<�)mYÎ��Xu�&9�9$g�:�0	�V����z&!r��*�ɗ{B]ۑ���ǿ�O�%���Bl�h���a�%�BY�"�M.�������nضK�5�*͇F"��Z\ż�o`Fha��7�cm¶>@"J����"��`��S�P���S�(��@����g��j._��l��Պhͭ����I������S��a��,�h�fT7�gёܖ�k��--�.�/�
	��6�g?Z�u\�H��@��O>�/��v��Jm���ݽ��[0}A�I��ϣ�*٨����Y֮$s Y?���6�Xl1���B�!�:/p�#"�?��_�]����H����-�V�|�2~#�K:}���Ď��/��=��q��to�^e�ʜq��p�]Fߦ��J"^�4�YQ�Jǔ�o"u��(��	n��7X�X�rfM[�:).XW�k�j �k�]i�iӯ�BkLn"��A`���o�]���xaEA�?,$Og���x�#Ms�Q,�/%��.��Z�%">���;��%&�*�Ǒ����$f��ۼ}ݞx��m*����rZ�ݓ���:�"�I�u�����{$�G���b��ȈS�o��xF���6'ź@��    �A�˽I� y�wqm�B���1�s
 �5��l���KD�ʻ��o)�W�'�����.	�v���Z۷��]�Z�q�i{�|ϙ<�}7Wu�FZ"�H�GUfzOI��?hE7���*��˼S�ا�g<+  ��*J�8�>q�I����d��Ej	4�S�֭�X�J?̊U��`Ӆ��d���Q�)��y]L'o89c��@BXg7��q5`��U��"KtO�X����\�2�!b��1�V���`�p|e'��C�3��afG�V�hd�:��?�߇�����YX]
krQ#�M��I�����l����g���s�_!�0)��q�^j� r������D:�8t^&t��vFh���H@��~X�+yn3vS):��v��Gq+��-ِ��&�8�;|O�	����G�mtF����4��X�t������,K9�M�ڡ+�p�Uk���Ph���$� �8ZA9����]�D��隽69ݫ���>�=����f�6��I���@����XFZ&�����T���!�U.��\�[4rf��<us=��^�ع���������,�����h���ӯ�}��q
ZՑ�=F��ηX��-�m}���f�$	�6��T�O�<_|Ƕu[����0{Щ�:D��
n��ύ�/b�H����&���L������;���f󧆅]�[�d�3ARQ��'��t}_��l�#�a�n�,��.�h���������)'��2S�8"vU�t��n�:r�D%�ʕ6��"�t@gp$r<*Az�e���F"������5��,��0�<��݈lŭ\��֡��`�>b XbB|
� �(㬙�C8R��<=�\�͗�u�!�l5��?�UV�V;�:<��rHV��\iCwy2Ct�g~�X����3Hq��~�DH�U�:�ӺSh���G �1$, "y��~J�n�p��>�y�lq9�m9'"��g�'�p5���p���@숫CoTm��q�xJ8�7V��\^�͍�f��D!v�k3�`9o����$��bH�ὣu9>�;�=�e�5�D����#!�_��gγ��"u_�U��h6��*���}�#�-�J>8�J[W�tȘ����i؂���x=�:��x����y�N�ߎ�>�!�D��wO�������<��»�0��rϭ��qvj�����5(ۇ�g��m��X[��!������[6A�@y�=�M���w���KA���ߏ���7�I�"~�QE;ft���+�=�f"h�R�|�L5�2R��ǋ���ѽ�i/xmڞ�����%�Dud��V���X������v�X�O׺�85D�����n\��A�t��XÖZ ^�������i��U�!����L99��u�8���?���]tʫ�8<��8�5����\#Z�ͪ_��8*�����&�r�`�'�!�c���!V޻�]���_�W'aM�H��։t�:r�261+�暖;��s0Z�H�9��c}�]�,6*z��6uϊ":�g?�(���Ʈ3dBA5F09��z��h1����$}���y��\-�&��ۉO��UGnG﯇���
y2x�u��L��2ڌz$!��������k�ȃ��3`G[Dq{[G�{�:����<IP�MRP{���)�ƹ� ��?�xa�h�H���i�r�:����&��Nτd(�P�=Xڕ?D��N����;���J�A��kBuy+�H������r:�m�^%4�l_	���A��A��:��[�CG|~fK���ߏ<5A����q���?�Lu϶����� �d�i>\@�0B��������|�Fu�������asB��Y��*��-ø��Y�d�³�������ݷ�>u�w���ﺿ��S�X`��b�WI�J��|��s+�D�0�J��z�4'~��1̕�����ߚS����'���I�]ѧ(ay�.t�v`=X���B��<(HJW����&�t\hbogx�#AZnu�}֕�;�oK��u;tm�b[`ߦE�"���������/}���UJ/�' �������gk�ܒ�M.��pk{�	ʞ$ڃ>���$![����GZ;[*b�����OcH$�3D��xɭ��v�)������壣���/�2�ۛ`.��읷��E6k0Q�B�ܱ��Cp�6Β� E��И�GXl ��J�R��:<ᎌX,��>6�3�u���n��"	{�C�X��gG��d:�I��f��� �5%aD�|���O�U]��&��ؖ�L U2u�Ǝ�M�_;kjj���� p=`��WJa�)����1��ap����E�������l��E�k'aW��(�4x?��Θ�E:銓�I�F�Ɗ�����7�,\)�G}C|-���)�v��.�6{���^�T���$*+���`��&!Ν�3ٮ�*t|���s@P랝��얹���I� OBkg��k���Fm��# >�m�1����E�P�DE�[Qv�cO������$ø(�b��08�_;������5�[m<�}*ޑ��eJ��еga�"Z�d��A'�SѲ���i�L����b�U�XO��rx*{�9j2�;�ձ�{�}N�7���]������8�_��#!�ǻ/g}����<�2�qR)�u'f�е����l����LF���Y8*�j8�cE�v��ߞ�o	��p�]/�I�h�J���VhD���o�b&�������p,����l^�c���<	�0b�$Q1	�9��eؗy2g��Щ|9���t��6[D��u�.�4(�7�7���|��qi���� +�%��0x�3����4� ��Y���YI����f�����z{�D��^2���%��В[�����ECP�kAAQ���"�7p����p�;�n6�)�(ߠ�T'��֍���U��`zdO����j">B:C&1���eN�Y4�\�4����E�0#"�v�t�%�g!�Rc�a��]���ɉ����u�$�T���曄�G+T�Ƌ&!N��zzb��G�V���SMcձW!��W��:�2�0w�;�lR����h�� �vt���,�خrx%� i�ZA<r����q�H�"�C�h[�����@�ј�����.��-��-^���߈n�:v�%��<J�P$]�������ו5����3�s��
U;*�~���]��	��Ao}��S}����d� "� �#�L ��AR�u-�������L-8K���ʩ��]���T��tS�c�ڭ;��KmK��0Rl���+�x⍐Yŉ ��t���l����)�f����[���4�Z�6㓶7Z�g]�,��o���7��U�v"Y�_{�
ݵc�M���|cL�A�$��B��4z�x]��ߓ׶��dG;|F"oȧ;,�x؊i�D�ko��R(����E
��`B�W�X��I���iߝ�/kܨk�� ,�WY�˪��� ��=BN ��Q�nT�*��\��$�*}y8�{�ą�?�����5��/��*�
ճ�a��6aJ}tU0;;�	�d�㯼�{4�S���i3=��(���9�U�ҵ�E��������X����؀�{�,�����0Y?<�^e�>�J}F(��U��X'� ]��K��e�U�;���Ҫ���������g-�@3`���x"�s�0*�8���EP|�J��/�@mgr�҆�Y��#!�_g��}��Gl�`� F�+qZphR�q�Xa�mW$����!�L:�m�!�܏M@NN�e����$Dk�wN�6��e�9�&!�@�k��"�ud8�yHwsMO��tQ�?�{���7^<l�_�3����,xC�V3�ֱC�F���!��Y�v<�����Q�R���ɞqr?}7_ϋ�w��"���`)�U�:�6��z)1n`��8���H�ߋxa�.^�O��_S�1ESq�U~�(U���-)R�u\�q��wTZ�n�H�Of|Xw�RJ�a ��$�/�b�#X�U���Dو��aԕ�ӢX+�U�\���Lݱ�~㤄>����    �<��9'1]Еd������:~�K�N
�X�Wf���vW�a�����<)x]��o���t�&�Q�C�	�8GG6D���dX6��z�.�e�]��l����n�2��I@�j�3����:ѐ�[��G�)�Rt���CY����is.�ΧK� �G�>c����t(�8,�j���9s|C���C]¨����E{w[|8[o��E�o^�����~j�$$��.+2\��PIi�;!���Hqy��\����WAjF�
'}� ���zNNKG.+��Yc��c���C���Ha�n�%<�xަ�m˭7�n�l�Ӿ���_j��;���Y@�-i2s��c���#n��o��r~$y>����#@��[�H$Cי�q�,3�d�T��C倛:�Π0y�K���)����������?V��
�D�z�6���J���"�`r���R�?o�}�99컾�&7Y4ݕޑgs�>-.�n�/�gH@��ߵ�9s.�R�k-��}��VGZC�@�J�.�D��� @�=ͦ�����Ј��#�dE�H�u�pF
;4�ae�C��
�u"���`W��HCXשs�}M��9׈D�!�/�q{�"���� RY_~0,K�j�\i�n5��H��῿��D��Wϻ(�9C�'"n��
��Jڡ�,�.c��j��@^���������Y������}��������y����C!�h�g�r���q�ݽ���ԗ�*FS �~<I ��<d)�Uv}|�ҵ����Ͱ��P���i����)C��m�V�"�U0�k�#`C�@�
��#���}��_���7��EU��x^e��Զ�:UHg2���l~��=_Aa.Qf9�=��N��4�03�o�o���[e�J�n��V�¨G���N&qI)�jt�-�c�m]I�������gW�CEpt�������X�Z�d�0�J!�qV�78�m{�`J��6`��H@������e��H.����q�|�)�R&�\�p���5�pU���G���t��D}����̛<I��#�@��v��Hu�f?օ��bλ�d+����&����>g�n3{�>Z&g�v�%��d��0޶:�B,����X:Q�&A@�U���j7\\�������w�SY(]����p��ot��B�m�4��c�p$����_\�!��������ram���ƻ(��C=�cT�T��b��������BG����CI^���N������g�8�pަ�3f����~|�J�Ў��q�{E.�@z۪n�:�� �ˆ��1�oo����<�\^,x2N�*�ӱ$}}��_g�q6�������U�Ի6��(%��z�xܾ��6aڮ����>��cbM�g���Y0�r�Cdۖ�c�Ĩ���1}_|�~><�'.�L7���(P�9۰Jy�'G�������&�p�GH�b��0T�����|��*P�.JY;�q�Y�����"�!��g\�\7�މc��Ln�b��@���="�J_���ۓ��O����	*�Vqԗ��u�pq_���+*�����F������v`����O��.���JC.�����FD%�����촉.��}x:��t���s��@���{�e0c��M�%>�f�#�U�ۡ�ZHJ�uu�^F���*ܔЃo��x��14�' ~?�ü��,:�����_A���=W��J�'n��1�~�B=�J�h) ��xN����+����ч�@��1Lmgt[�LѸ6��i���¢H��4!��=ۀ��$���TKMC�]���w�'�9q��:xJ�����ۺ_�;��X�����008x�s����������׮��!�L d�-�NHB�u�<H�K�%��o��J�(�'���7^ӳ�U<�L.$$qx��D������I �7�`��V��]���Б�8<;K��sq����DJO<e[�C�\ToN0R�p���U��x����R|sHE	�]�1�������>u��ϓ2�@r�C�w(b\�T��d7{�Pl�ع�QÛ�J���n$ �٣s���#�2�ñ%�5�&��=aץ� ��_H]�מ�y8�'7[�Ap�r�>J����G�\����Lΐ8.E6EǍ�e��!��,�'R�ǥ�8�HE�o柿�9�fB0��_��/"����y��c)��
�{r5�UU��dZ��K��;R�7���O��	��UF��aC�nf?Q9�����n~ J��Cxű=s-�K�����9x���ŏË��Y7�,Gu�%�u�] �i��p�1z���ś:[5���F������/�m�$��M4��3�q��-�ı%\)�>�^6������(ˋiO���ڑ�/^�y+�<G�dk޴���!���=w��Z-���:�찓��{pjc����I��>r�K����9����ܺs�����,B6�ݷ�����8�Q�Eh��@��Eti'��U�=�T� �7��#e^��<l�3�5�"ֽ.�糄F�I��t�F�߶}��:_\�'��2�R��rɭ���̹������	��p�\��6&��22����so��o�W�I���!��ۘ��v�_���!�'m��.��Jٳ��^����\}#.O:x�?�7ۢ H>��-�ء-�J/�Hi�H.��z�Un�@BD��Q���DJV�l�a#�5��uKR]�Y^I(̝�߶�
;9\�����j�S���$��9�﯏EpɓY�b�*c4D�[��4�,j��m��5����\e��t���O�	����䍓�A��s4EF�u�?��\9� �t)8�x��{�(O�����͒���p�J�ɸ�IQ�qE�]��gW!�p""�&�s�b%������}����EN��"Z�Z��Ѹ��з�kUSI+�#�a��J��5��+7��v�c�q���.��3j�S�7�PXu�&����GsI���ok?�I:���@"��[̭��i�3x�Jl �鐴�A!h�6�	�dS�d���eKkW����<��J3:�~� L窴o7xṠ�lQ��Ye��q���L�Xs�C�\v�8����`�5����+(V�ֵ#!����t�v�_q��l�KP��[]��;�78��,YJ&�N%5(���x!��to�z�ēp��m�x�)٥�k1�B�<���l~���Y.�����8��f��;2"_,}ñޒ����]�'.Z�6h�M��<I�:
xi���C�3r��!K5��򃚀��O������3�HO�&�A�	�:��e�:�O���t�#��@�3�0�]4�3Dr���2#V�ȉv���#$���������O%�cB���!�PW��t����tVl�P��{��v��h�Ȉ��w{�lX2�xN�O�
(-j�uwU�Q����]�.և�3�Q�O����`��G���J����	O�p$fV�j��Q��]����#�/P�$F�Yc�aw#�Q0=���x�A9J�Bh���ҡ�a�!�a�O�?���r}r�B8M�B����#"�E�7�m��y�+�2A���$��Ru<+���yVQ��?��!Il{�1�e�	�v�ӿ�!N��焏$�&휘0a���(ӡ�I����KE���`ր�X5'9�@|���g���p1�~?}�xY��-LwW52��4�F}�%A�0	�;�v��1X���4%r̓y]{"ib�2}�x�gC���[՝XOu�s�$��&�D/��4�S�+�/�}����?>
�&i&S�l+;�^~f��=�e5!��8`���λ�\�������no���z�������:�Ǚ�\��N�r/��y^�f�P
�u=~86�T�OX���Aڽ�b���̮^y%��-4d#b����w�,�}(�g��_-U��f����Ȣ�����1ڷ_߿_������8j�b�[/�[��A؝=�
U�'AJ�����7����}y��Q>��Ls��9Spz6�֋�fv�I�<:����h�i�+ }��舓s�r{�~�e�1�HsҌg��V=/ޫ���Pf�R[�U�    V��*�����G��O���%������]N��^֫�RT�9R Ft��@�$��xf��4���,M��m����ְ�n����z�N�TN`�:�U�K�6���P544�����شF��[��O��X/):��0��0���jH}r�"��m�S�C�l�H=&��������A���-޵��!�iS��r��hK �;�t?��~PP�jmr�c:�*{�Y��q7T<��m�v��=�c�ӔN�E��������ޭ��]�8����W��S��=��*�K�����M3�+�/Q٪�So��0�"#�P�å)\�4G�a����Ͻ�s#!gg_V�\/�Q��5��x��W6�z��*�e*b�ԋ�.;�����H៯U����`#���I��$l请�[��/�ϑ�NHl8��`�?���{��7�Z�f�ԑ�̠�o�W�7PW���o+P���G���!��_ߤ��,�8-j���g�7k�xe���H�Xj;�-Uw(�G���y=�^�#����X�O���B�vC��8�<*Tǫ��"iW�H���w:}���+'���@v�Ŧ����D?���gԙWqo���j�ƴ�_�ށ� ɇ�0��˳���U_ߣ!�n�2��Os�b��\��V����[�ܫG��Vx*B��)`���I�sJ��B�\��6ޗ���Z#U���mʑ[�R���pV�c�_�6��3�E\��+�^�CX��Pq������؉7���'<C���y�^C+)���^�D-Y�e��:UE���'�7�Ǘ�F
���~�>۬Y�F}�D�%nV+��[��W)�m8�}�ߕd�i� 4�-�q���(?��}����g��E�π�0��Ǻ�uK��e��:�)
���̀{�����S�V�&:���6C(ߢD��x�0��#�"n�4�!M���������0^��<��ٱ������}Q�qh��zk�VuQ�l�Tg�����XC���i{��o��z�| &��O+b�01�+�!�9��J�h�x��㬞�wa"`�3��uk���PA�a�8�W�5R�#~:�Y,n����Bt.)�3V%�8ɱĐvn�]G*��}��?��+�/�Qr� DĲ���Q�IM;��o6�z�)cNn2Xw��`����F-�\�u�l������ߢ��/�R?@�@\K�[<xAT5Y߆O)��I�ۧ!��͸���M�=�տG)�xn�����둱叽����x�k ��D�K�2�%�F"���3�6]M?Q1�TKqL�O�Qۦn���1E�q,��d`�Ds=�}�7<9�������7�Qtr:kxI�	�:�(b�Y�{���\�.�,;�%�����<�H3/��`o�0�:��d���-����H�*�"��"�]_��H�n���G���H«V7\����6;ʏ�ޙ�:��2�^��x�Ʒ���;����Ću�n<i<�������h4�<�o����楹�����i;��;�8M�l���<%�,��P|ߔ�3 �]^�&!�ӳ�@.�xO\�Z�q\�3��|w?�,�}i���3f����KHUp6*�4pM����Ky�0b�;_��1!m4oH��{Q�t��8:���C��D�7rg�� WZ&���E��z�����iu9G�1�#��у%��n}����<��������K�)��8\ȋ�>��L�佪	s�wq�zf�D���O��mCVY(4�"cs�����(�uwQ�ޮ�?^Tm�	h�[� ��o:�\��~��ʿ @��\��&Gߑ�"�������!�|:����wϳZ�K�&��z����U8�������s�:C]A�}Cǋ�ќ�+�����n����%l���X��]?�����z#�_���:�:Ͳ�=�}��|&>�����6�LW�U+�}Qφ���-dk�w/� ����R���^->=�>��N���6��!�^�I�N9�Q���ySWuV�{�ͺ#6SM�jXb��ߚK�����*}ݼ�^�˯;E8B�<ʆ[��B�b]���z�U&��A�W5�o�{t*��ϯ|�ey��?�o�fٷb[r��BT�əsd�Pxϵ ��XMh�Su��ǋ��Y��|O�<��л�s��a��󡈸�z��IC���-�6��]�I�F��.?�`ځ8��V|��ּ�����^ϙ_�t�\b�خRP�mMlx��=v�D{q���|L6�5.M�Y@<�mU�_�7s6v���:^�eX�x�U%��mGG������g�h[�2�F��&�Ez���$��ϺW**
n��ה �ҥ���T"�|�����v�}e���8�x�(��%��_����NP�ٴ����)���m�ۧ!�߮��y��` ���f��\�C�G�o���x�`��r���ù�6 j�x^��N�t�#$>�E:}�Im~}�8�!�(���՞��Tv�X�R�wج��t�a�x�������x7�;���N���@GR&3���&��ܠ\T�O�	dO@@��Ul�'�r�(�hq'�/
�\t-��������H�e�	yH*?K�jg0@��%��r�X`GSo{�9;^���y��D1��(E����Y����&x.��z�$�ϡG$����qN	�}_�;'�����<}<�>ryb�nZN��!Zg���~N��W��Æ��R	"[PHN?U3<�4o/w���'Ա��Q]�j�Q�{~�7��B��������`�%\���ent3�-nӖ�e��I0����f�J��9�y(�&=��$����1"E��i��u������e�>̻���O���a�E
@�O�D����]�e�H��!֞��]݆�f��' �Wם}�~��6��4K%�5[Dߊ4V�'��T)�P���.��l�rD�l�	��w��H�g	����y�EDPɭ����ǡҴ#����^�=ҕ����.�t�$f�۟����	�GiӔk��k��>�R���?�L���$�?�`�p�S�H��������������3����J�.�R?���yA��zL�sIw�w
v���c�9	b��;%�݋�H��8JU���?��B�I-B��O���:<L1<8���}��xJ:2�����Z��Ɵl�%��T.i�tw�Пb��~e�۲��.�su<K�D�{�9X�M�(l�E���i��;Z�� �m�/޷w�CyV���BV�'= i��Z�r�XC�gUN2ŋRy<�h�"M:s��A��-�.p����-r�l���z>D���M�*��З������J�{��j��K(�=�����!f��}�j�W/笷�&�t����E�ҽ��uA��h�s]⾁�!W�4M	tS���{�6}�$����糆�?�j�&oc4�"T8�:.w6�H����2�Y����䥎#]t`�!��h����<e�kKqFh���}存N�~��AQ���O���hyC	oi��>D��~����):�eS�3�b����[yi1���\��o�"����ί;����A����Q|=�=&����73I���lqP�(�॥	�s�F'������i�t�j~3�3�������*1�շB2Ȝ5���e4A����g��+k �V }U�|������vk[��y?�"^�t�ӢF�k�Da��6u���>z��({��5_/P�)T�7Y��oKy��k��WyY¢�5I	�A���\:op�����*�'����<Z4��{��|�f�1�M� 	b��M���C	ayh����6,����;=XT�񥋪�6���6O�R��ͭ�4A������щ�ck�d�K���<���(?PW��<�t�o?x���l]]�H;�	�!��*���P���N`YC���1,����Q7QZ�7#�6=JOf��xit[����]х[��`���& y8�-K�z����Tާ�-y5\t���q2/�k^��Z\��TU�����y�Ym�=ք}Uk�8ʖ-�z��$��gtr��p��<�CP���K^�.'D3�A�7|�G�    <�Ĵ���_���{��q�X��_^y2�t�[�VQb�L��N��7�yHfa��o����@�(6v�U�z2}InӒ����ħz��-���1� ��(�� ���5T��ߐr�[�l4b������j�ޗ<�/����G�����Ru�"��R��P�$ c:�7�d�㹤/\�b��-��x<�+7�sx� ��@H����J~[~ŏ���C:�D0��0?�X�P�kȌ���~i���0A�H�:��ɒ�dp��:V������6�>�(:p���ډ/�]hY����;-���m.�;"��{]�^0������wP�yZ^Ⱦ�ke����{.��Y�m5��D��<>x�ݝ=e�˵�i�'�Q9[�	V�j��rM�"������*��¿�}u��(	�eD�i6��Yp|�g��T�1��|Tpt�b�&5q	�L.PLh�)�����)�$���{P�!��K*�	�U���RW�eU~([������#���֏|�\�9E��-���J4A&�r�Å�`���E�M/c�>R�qb�~㾤�Q.<�����3Ϊ�4U��c���1�ԡ��g�K�[յn�z�"����.zN��u���lp�׿5�$ {�1���DR !�b�9~���P9��k�.4��fF<&���-W��%��A���R2�%�5� ֤j��g��75O;$c衅P>�j���O��},���g
��-+����l��_��8<��0�DL��wpW�M������r+'i��ۼi��D�p7Y�Xf�b�1��0ϑ��A,����Z�Ko5�X�A���c��b��q�)� �b�m*��A�H亀gڌ`k��tu��F�!���,��}�>n�8����[G�Z��3��t.8�͐�!I�*1"�>��n��).��ۻ��]�B����9͊%� ��l�?c�9.��Y+J�2-큸I�
���.���1�es>�����3[t���Fd�����챏m�Os|���~;�C_�ı��q�y�gC�w��^�]�lڶ�T�"sV�yU�q�[:+��!���F�I��aq�6����g8��"#���]�ܑE�f�Gd���2�P.
<I�ׁTY�J��&�r)3�r��Dt�����!�$|��Z�}	t[�5c�}T,����W�vA������#���������킧���FyةH�/N#�7ɶ��j�S�l8h�^*��ED[z�;���^_�cDy�U�1��5r�OG��v$4�}U��W��5�Tn�b=;t����s~(�ZCM�̆!�E�MV�P����(�c�]��@%���� �Dw��y|}נּ��]��-pkو�ɼ�a���p�MK��N|\E�RoBCWQ�S.����g�W@�j��\E�����f�����94N���t�R���j�����f�5P��⨼~�^,/.�����!K.�)�i�.�Q�7)N&��'ǔ�j��ɠ�C�4��Q�/���:�`w6 �![6KΛ.slL���F���&6W6�%�p@�x��G$CGCg�L�ꓟ�#p�CW�dÕ�딯Q�K��K��"�A���k�1ys�{�W����{�a�@�2�)#ԣV��T+J�C�%�&�+$㪌��K3L������3o9�A�{�e���L;����:وR���$��[oDr����$������I�*5Df�N;��Mvy·����04_��F�?�J�IY5=u��+z��?�8p#W]?��޿}L���K��]���r����RN�ժ�&Q�l~�ɃL���ҙ��Q,T�� u1`��q���b�^�o��#���d���hN� 9i�ZQ>����r��m�Ӝh���z�)� :t�i1�_����l��BCH6S2)8�W|���Tb1�H��@C�ة!7�r��C��@��̸�����&�-���e���b\�r�_���C>��O�1��3��+��� ��68��_�^�%;?�����Y��h>��<k�z@�V9�L�m�y�~�Y�C��ۼ{r���b�*�h_.��A�}���1Ռ���CБ#k�5�����80�/+-���xq��p~��d��r��3p��5��Li��X�R(z�(Wf��PW����e��� >ߏ�w|8ҷ#�@pz�#X,:Պ���$c�%�v%��P����eM�AT�|�� ��K˼:�'�7�-9g�5b��k��̲,�7���ae^�V�t%��<6;��'�!N�ß0���=�C���1-����:�F�d�ɳ��50�]���Tq �!Ph)��B	����fv:�:i~6g�� 0�J�����&Q� �8)Ҵ���G���dA��kI��A/�#��H!4��d��Ւ|�4�k�5Y��2�~H�Y��z
����E;�� �vs$��5RH. �*m��S6W�lD�H$4Q���L�����Q�Di�	2t��֮O��u���Kk�̙J`���Q7�5�( �"�m�����p������k��A���7��&��}������ý|�e$�z��J����l:�}K���*�rM]����]��w��~�~�<�8��0��������h�"
9.s(�ADb��N�Ӓp�T ��_�轱�с��sn�5 �Q�m�R�������l�889>��B����{s\�����ؠ�M}]�&I���d�"y���s�����'* ��`Ĺ����1��ztw]]>�t�6J��A�h\��I�P�̋g3]�P��׷Pȭ{��+����:G���A���Vdh/�Ү��/ʠm�be��i��֤�z���,|���]~7�dq\��ۦ8�e#����:Hq�_o[����y�
�o�Nx�[�����f�}�ӄ�Z��,����D������Ɗ��Y�����/m��=��������[�t��ƨ�G�)͝T 3�ڀhE�*���(c�.Ʊdz0m���R�N3�I���*̓�������2��f:%����N�R�Ɯ|�_^ӑ�s�RviMp-����J�I�_�\���,:O�Oc�{�閯6���*\b{���o��z2`��ʂ6�??k�m�W��n���K&t�%��/g�����.19���L�g��î����]5��U?a��lݣ˯���+�2�	�u��E�(�����)V������=�ߊ�J� ����n�O�w�C��*���������B���6R�=TSm`צ�½\c���룷�4��8�/�y"��-k"�4�t_c�^��Yo�6�k��'���=�ݞ}���o��|�jA4�m�]X�};�0$�9b}�b1ɹ�(�]����Rq�Ak<�8��ӻ�^]����� G�9b��x��8�$M�Ф�1�0<Mӱ5�D�h�Ȳfi�C��j~�}����!Yr��ْ����19���*�tPS���w\���g����軋 ���0F�Y�@�f�#��ZĲ��>D�`� Mf�\6K.��}HQ� �ߋ��sV�|@ 2I�9'�r-R��Ʉ��$����zT�>��$���өNKI�K.P=�(g݅�����~��4��b��q�䋪�鍙ZE:�h�	ԟ�ʎ{����1��C9�-󍤠B�!��g���e�1	u1����~𡖡%ˤ4�A�=x�s��-�)��\�y���Sj�m׷��d�t�ܗ�XtǶ,-���'��r����t<��˜����xZ�JAZK����h�pkRي�I�*���ޘ�Ǖa�W�?:D$�
	�Q?��m�O���-�F���ն���?1O�e�:��/"�L��Koi}+�K�!��_�� �	udP/d���l��$�����Q�XXyV_.٬i����������օk�H":���|�~�9i� G�l�6����W��'�ZE��|�Gɲ}Uԯ0�ZdK��}�Y���|m�4l'C�l�Ee%`"s��f\����-�O`���'�
�h��zRit4�����¼��jw+�?�8�ۊf'q�h�j׆,QO�,��;8���8�ȇ1����_����.�>��E�@\CJ(E��x1�7�F�A�h�L~Z3�    �	��m���ddw�v��dHD%$We=k�۬*Պ��B�o[ЍD<B�G�R���ll&k��h�mv?��� ����]-�g�F6��_J8ϳ��aۓ�7�^����M�(;��a���=|���d-�NӶ�@��F���q�6@��Y'�:�$Q�L(N�~���o+�[E
�oɌ>)_㯁%Ц�f3R���'3��<N)���:=~h�υ�ݶ<���cr]�v�%n'�&�;yhH��	T������Db��Au��Y�)/܂��f�#���g����A&�F��S=�O{"P�*�z���rc=���ƣ�丅���%{�$��x=I��t��,f�N(펨��(c~Cw~�%����՗/_z(.�a�+clL�ɪXű:��?����i�A�L�͑����� �IMO�_����'a�Ke��2��'v�l���:R	p�	$#=)A$�X�9pO����z{o���$y�x2�3�,� nqNt��F�d��zR�[�_"��Av(�J�~���=kcw��K���n���!� �t;��l�E֨=�d�>��PN{��(@�l���y���\5h���u6o�"�%ޓ��
�eJ�vQ��Ҹ\)@�h�9彩1DU5�/��9�Y�-�"�X����V�?C]�-�4Q�#$M��,��t7e˘:L�_�I�G-G��kb���-4�q{�2���M��ٳ��(��"r˷φ��$i-���Μ�����-�����JA��(�U�jyC��h?�}>y�^�G������F���ʍĚQ��3DF��v1��I �Α��;t�]<ξ�v�@��fa&�5+".gHS/�Hl���"��N���s2F�pUA�2Q���i��_{��'	�T|]k�ҝ�F��N�÷�ihf��������l���N��(W��R�E5f�q9_wP����@�W�(�Z�_� d��L��"����._Q�d�[�z�b7���C�Ʈi���7��U� v|���`y1=	5��q�{[[À">��V����b�3��-���qw
�Ӛkb�@}H!m�}Q��"���3�o��8-���H��g��������$ wS��u%�v�f
���*%���{�N2�������.�M�'eT4�GGu��T,I(�P`���1p9�M���(���?e�Ds�1{L8���tr���Va)�X6�h�����Q�݁�r&�]��6m:�g�.�äQ�8�x����e���<q�Y��,m��~��dE,I<I�K�HJJ�zH\;�Ƚ6YQ�;ތ� b�{��ٱ\(�x�XD�>k�lK�2pk�J�i�Z�8d6G�>Jr��f�V(QT�C�r��z?{N�"v݀���w�����c�H�	Y�Mʺ	>�nJm�XL�UcJ��0�΢l.�����1x�P�e�@ӓ�Kԧ��\�F��M^�� OÑ�2� �o{�T�� _�;�v�G�`FG��us�epv�K��w�ۣ���Y�H���E+�B"��E��%U	�x�7ٛ����\Z+q�^�F���$��g�_U���|h#�z��\rp�����L�Y�Z	 ��IO��R�k�����t���@��G�����가�Ktpү�S���ք L5�r�5����ᮉ4�	�%�����O��{�Ы� "�f7s���a�sK�Q窕�'���6/����#�M��3��3�T *Ѧ�
FC�6���5�\pD��جLl�};�zT&�����2t}� �.8�������>,�9�@N�+=�N�"�Պ풯I=
х�����|U7�T(������b}�f��i���9|@�K��3��"]�5YL����	r�~���°�[�9RQ�����H�o��_R�"/ c�k��h�D���w�����x���d��RjM�F�ۻ��6���"ŴPk�5i��е�p�򎥉o������Q��� ��i����k��!�i�J��eJ������C� �P�k�F���F��~��$�7(��2�ք`NI�3����"�z�G�S! �@���m]��X���%��пz��G�{��}��-,�-?%3�J�ɬ�����K7�I�+���&q��u��u/SV~�?Rv-API��l��V1_����r)f(�����d�hbt�D�!���#߻�88탙�n+��r�Y7"���d=1� P����x,S�G����kbTN7� ��_�i�hԙu�7��	;�&'nS�L6����R��q�����]&ңM��C�ŌF�,*V��F�� ���d��Kr�J���t�D�\�C�H�@Sd��1َ�=�� ��s��i?�gr�%�:B�]�Z��/"2X",9!ǨQ��?��e����%���� 2��o �,�L6��	� �W�L�s���\Ă$l	K搑N�xqa�Ó�!�L�P<f�mΣ��W����y�(ݖ��?�������Pg�2y�}h\�쎆O��)��|.@9ΕI"�Ϙ��BR�Ւբǎ����tp#�%5����������mj�o<�)�w�=�t��qI�	�k�h���ڃC>�|�ok�ˋ��3C)�5��.o��Up�;7�t�S�Ɉ��w����Q�i�"������<7Kyx�o���v��y:�({fDuT�4U�Ԛ��J5�� }"?x�a�AA�kRZm�!hU�S?�O!@�x	ZW���R�Hm�
�y<: ״ؔi����
��%{Y����~������N�إ
\��."G>E��H��pE�����r:�\�4m��&݅���L!�@��m�X��m��#�-,e#uG�>��|o/�G���A^�mVՅ�}ںOS;���U��)��zL����#O���xG��3m���&g|G���L�)�G#Щy��\6�w9�,qt"Ĝ7�k�Of �J�7xj֟�d�?Pί#�M�`뻉C3O���Bq���"Y�N��u�2����7���i_"��QE�1��������x��ҏ�<;g�Th@���U�����vQշ�pR����(�<k�[���ܔk���կĻ}���?>Og�)��n3\�h̽�@̔5�]M~�fc\� ��?)=��/���A���[�\#����R�H�I�Hx��	�)4�2؃L�oqF+�������>^��ק�|7����bG�/d#M&��+�B��ԴX<R��UTV�o�ވ�BSO걄�2�6��c�B�CP
.�7)��"������h6x��ǲ���f���S_
��1����6;�����6P"yE?Ӭ�Aoϕ=��� �
��L��|R��0�
�|w�㓵Q"�SX�Hv|Mg#��#�x,4��E��C,}w�}<m��m�d��u�H$����5�L��*�I��b�j�-�S[���ǽ�)�_'Nz{{\����szPu���֕n���`��P:��+L`���.e��Gӓ��S���0�����':�#������˃��al��V�tt8�p�ci=�F��������Yv�0G=�h�Z�Ȅj��Ì����F=:ݜ��%�)�k|w�%4�Rǣ��:� y���{��������i�kB��!����Xj�w��#i-�B�'���4�1����bBA��;:��9_�z�
:��T�b������F/�HX�A ��$�G�w�������/�FE�b�X��3���t1�� e�!��dД)�^!p��'��
o��y�t܇o<j�X��U�)�J���o����[r|�Vo���6�,yY�����h$���Zc�l��xZ��D��V�����-�R6�FO⦩�T�ǆ��@����_�*'�$������;w���x��~o�����^�F������ͷ���`�eȘ��J�������\���l�?�yiB������Y�E)�~����*�`��d�F�O������R�G��k�$j��x,Q�����*>;�[�t]�k�x��>���,˂?vpNy��Z�dE�����XNO�k�~��<���=��,0�    ��!���d3���J� �A���@�M���B��qčStߛ��i�b&��O%�J$�l��_�Z *�� PM
dP�AM?����->7�φ�,�4.g@@[�f
�h���Y}�k&Hʍ�� x�	�1*/P��F���ܜ�x�7 )�L��?�G�F���n���HR�V�\y���'��I'�ѣ��_.^>"��f�XTf�L���3\��I���K�^L���;�6.T���ó�t]�,����YJ_Y����A6�g�����,���9}�����I������_�Ky�))�U߭Xu};ݏ�lD���,L����`ZƐyS���A���4^
�!OL7 �o{���l���gb{��М��8k�]�@��a����/����*����E�E�xMQ&|͌ɒLkP��G�/}���v��8�B�(�}��v�Y�W]�8�I�>i�)�[�������
���6�7���Ð@�o�@�)!��yx��.� g˙�-��V�dV/p��TADɮ���{Z\�O�����4l	@�\��'��d>�ـ�HzN�3gA2��?64�tN����6�08�2�!]t�a�]��5s�� � ޠ�l��'���`�t�:��⽸������D����L�gn_X���Z�M&gS<��iD+݌�:B$U�W��È���E�~��Ŕ�_V�¢��ȼ�zA�ʤ�Hbہ��0��� ˦^�z3� �|l�b÷�����fـ�w��F��S��"pL'�����Ψ"_R:�����3jw.φT��)��Z�qɂQ�p܀5�=uC���Ds4M��TgQ��Ü����E�A��9]�nf�obG���n��C���&�9�og<�8�\�l/�G���K�iE@3�����Աld�9�?��vtx������{� LZ;�0 9 ����(}w���L�q��'���Y<H7�n+�q,�p��8�Gw�����~f<%��UѬ�� �1ej,��p͒�rw�H��O� ��b�d��/�W��l��~��M����,��X.�	�~����m���<��n�p�zg�v³6B�9S������[Fi�?�sC]<��!z�RS���qĀ����Y��Y�'|`�Yf�4�;�d�	}=Z������ȷṺb�O �������c��es����	OF[C�'���t�1�p��)
59o��c���:���T<t��U!���A�"f�c�j���Ge�X(�o ߂V�
����6��Q���3��\e���Ł��DETg�5������(t?�Z�s.�t�KV��
]:�@5o�J�PJL�X������+�z�^���W�'\Vò֥j���Gv�����=`��:�A��:�UJ �^dI�Axy���f���0R�x��N�I�j��ˠ��Y�]_|ǀ;T!��6; ����̕�:_<K���LYv���ʊ�Y=��Xjظ»���x�����gG��.����?Z�T�/-�;y�Dkr���~1��<F��Ħ�K�AC9^kJES� �����͞c���M��I#ʹld�!��|r@�8�X��	������6�7���+(�� ��7�
g9_�f�T:!4�27�3P������U��I�~�|y_?v��'#�(��%��נ!��l�7�`@_*��d�:B�2B�L�ˁ�x4�X�_v��O�����Z����u3���:{B����В�=�aYg@��Ψ�Ȧ�������o�xn�Z.̧_ߩV���,!���#f���Ԅhl	���5~�h6]vp��8H�$��jsΓ!I��&n�7�v��u���6���-:�'OsUY0�qS�f��+�����_�Nzr�oxWrx���� }�D��([O�6��!*��՘�=�l��ZϺ�xp>���<�/S:PȾgmڨ��l3�$u���!s��٤�]6���^��/��"�����g�i�����#;&�*�bַ���+�՟U�4*,�曨�t�2KjLZё�� �T�ۣ�s�U<g����ɣ��ȅ.��X�};C2xՃm>J�/��o��SS8�a��(I���k,�5s���ۏ�]@r릈g���@DXv���k�=�|CR���QbN�#����i ބ��f�>��}����!߬�$��Z����FuZ.پ�kL"4]e�z�v�
ԙ�cM��#���5|�4��۞��!�k$�P�H= �̲�R�e�������O�#e`�
��݅?��?��y�R``�*��|��MS� ��-)�)�mP��YN�w�u�s��sȹ)9�x]����ϙ9'�QxE&�a�=P�a�
�@�y�2�Tw]��:1b��ȺdwZ�� ��3k�m���l�T��w�� Q�L�@xp�"�Cga��cG���\�eR4uM��R�f����E݀4���18���T���QgQ�_>�^�|6`\���63
���������&�(���2ڌ��Y�pc�a���_wϜ) ����q��h���l��<��#I �AW	�Џ�$�������Lyp票�g��=��E�Z3o��1v2��*p��Κܤ^!v�Y����[�
{��;K�4�5�d�A�����I�S��/��m]��3��f�_��}�~��!�3��]C��:Z,�N5_g�o#)0�ˠ9ڪ�t�u?��dˬF�qqqz|�~�gTig(a\v"�ecN�Q��s��@��B�:���6�p�i��~ �Ǎ�}�����`�A����ņ,&P���,�l+x�՚��=���v4#�$�*�����k�����gv���e]ԊS���c|���l��g�L��|U5g��tk�d���35��>�n�����˅,�Bq�����p�%�]�%��V�7J��O���W�Pр���~��.K~e�xȦ�VRJgd!��1K't���l%c�v�X5�� �$sע����ʑ�rI<|n��#Y��o%H�#�a�g�N,��	�>�,OS�AzM��!mA�S�D��s~��%YV`E�MiV�Rݜ�F�s����ھ��2�?bց�dpƝEt\�\�<K(�� �aA��j�rfN�_�Drm�5�t*H�c<��)���y�;�S��=�*9� ��&9&�`0���b�%C7,3��q	Zl�<':pi���/�[d��c�4�ņL�����)'���h�JV��t� p�rC�E-.�&3�F�0��i��|��,q]�L<��g6�N�f����Iu�d@����z
.7 �-�\���7n�X���?��Y���w�w�$U�`�:��#�@��S�����Q���~�������d=�O<�õ�LpA�]]���5#�[���@�����q`0Ɛ�o��.H>��b��o�}ǟ�=�rp'�D��l���,&}u�����\f����;���N�W�������WzÓp�z˼��;�p�-�3)�� '��j�Qf�PNNF�V��Q�Ǧn��b�}�J�D^���_�欙(M'r�$?���ty*K�Po���5�oF<�|�����+�3�dX'Țam�s\f�	��3�Ӱ(v'��΃sOm��Kk�+�U5��;]]\���m|�!l�Q�7�$]�u����O|ʞ����Zw�5��QٗW�C�'�W��]�����Dփ����l�ZZ#����|ɇ���!�y�G9*\��E��!J^wG'S<��'l�>�i�i�ˬ�H�S�Tv={�F"�jjT��[��x�|,�p,�f�@~x��_gk0�)�)� %IM��6q�c_��V���c�"[������)O��UV�ɱ@�u��u��t�<��J3��>K���,%4�%eY�y�du���(��Џ��,��{��m�o��5J�:�N��1-�0��� Gq���������Y��x�@\]�ɮ=���U��3B\�'�%W'��T�f���C&�	��R�^�0Ғ���iԌ��}}�S�8�F�8��/#-E�z�z׷g�c.:ֈ�z�cub��i9X����<��_�'���4�'�CL��<�Z�y��:ۏ��|    h��5{[�!��C��b�������|��q� Ӗ�9�w�-B'^dkݜ�(�&��Z w$���秃�*JЅ���"�7�cw1�8��8��8��b�7rc���]˝�%�C,W�׺�X�7�G,P>��;c��׮ț����ö}@�?²|����E'��+8N��"t��2����>�!J6@���f��8K���͌�XhjN.�}���^�kn��{���2��!ZR�Dki��`R������G�3{z��,�����2vR��NT+�'8���[��V��Y�5��.CnL:nVٲܗ�0���,J��eV]�6+��&^E	�q͝	l;Ŏl�	ym��Y*��_|@�+�����8?+/��zx�C�9�P"�}A�������-��$����\t�>���o��s��A�CPI�$���%�鲑{��̊X1�z(�
�i���4�V�Q�V�]�S����9�:q	�P���P�ܟ4鲩`�,˪d�~&��UP���(	��S�5L.���`"���/'�Mpw�w�c}�V~+J�*D���<�+��c���s4�dC�Ռ�"z���#�>�|Ài�@R��5��5��r����g��� �/�t�򞚹G!��{v���Ȟ�$h�Ȳ�m�I��?b��5�&E��t��I+a�!���v�4���w���q0�(�-\5�4�#Ib|�4�X��3���#p�"��Hf;(-.�DL&$eO���{��@��7LI/���6���5Op^�{1���&�zC�[#��6�\�U�b��\?�8���������Ay|ÀY䨛��مn橶�M�S�4��7=��ul_E������8�.^7���wgCP�K��t�֢��g�qu�t�,�oM�|������߽���'.߭⹜���	��d
����j\��$��Y�4B�o��6�s�qR�޺�H�]D��,�<��[Tz�֛�hw]
��d+�'���v�T
��`��0� +�уCM�ߓ>NFC��Μ��o��O<�'�Z$r@|����حU+/���C�7�����o"��ؚ6��9�6G�>�'w�<�/��l�&���1_�r2kִ;�$dOy�3B~�����"��;���g�oW<C�_��ѫ�׸��I��^�jlU�ENj�B	
��2�6�=9�ݾ�F�2�]=�pO���9/�P� /��yɉ�h�ZyE�#�U▤m���t��k��q����7E������cy��K��FK���~w'y=bW4��ӒUR^�2q�O�QR~CD�:)�*�~���M�+��j��c�-�ػ!J��Kp"ö-7|�-������>�Y,p߀H ~�^k�ȗ�)]���z���Te�$��?p�>�F��[���,���A���dE��g P:Kd#o&˕��1�$4B]�e3c��y��ݲ˱���o�.�����O�>�/#x���3_Mv�D�(��]��b5_��)��K|\\ܟ=��6�E��\��J�-$S�gZ'����pa��k���Ta��9l���>U�k<�x�8����G<������Tdȴ�%���LAV�y���	����4,���Q�^�3�C���zIoy>m$�c`B��U����x Q�-�}(5&%{(�&�i��d�d��aC�8�W����9Zl�u�l��|�Y@ך,+�������,���	|&/���M���SBV/1؏$������*��'^c+A(	�/�T7��d�G��L��	=@oCGhq*(iBI��fJ��׏����,\����$$V�7��C��P�|��H���I�+��e��W��X��0 ��Խ?�	M�Ob�C��GIՉx�Z�n3�r@=P���8A��f�z��DIծ1�.~����<{nQ��[04P~ܲP(˥g3�ȿG69�����Q4�o"����EQ�>o؂�l�$�®�rY+����*}�2{x莉��f�d�r)h�(mo�"����UyP9���0I�����\�4&����������u])РY���Y��!mG�L�F���}}�#��y� ︈�ݞ��"Q��+٩E���tɓ+�Ćt�@�3� ���q��dd��Q�zTG�q�b�*��<�J��	 ��@���`i�����`�]���v��y:�7�#{#�t�ѡ����K�ӦFaM@��
�!�����\�&y�,��"�e�&z��U�?��<@��f�xm����#n\vMh�K-٠WF>y�������:~�y��������{j:��T�p&����&p6�7Vx��g\3���+���goo���p�'3��Y.�����7���pG�H����{�<�m�w@�ݤ��C�Yt����R�
�d0��P�x����\7o(�������"\�y	L�u��3mΏ�ɕ���:Mh�|��Cє,��2��5�5k�(�QYv@�7��6mɂC�!=�n�P��~]��S��F����i�]�KL��E�+^+D�ZtR]&��p6�'������s�~.n���9���	�T�ׯ;�*B��$Z�h�'����!�����"���M���+9���ݰUh�ndM;a	�m��d��&[�!%=T�-���X��q�Ʀ]�=�D�x`�y��:���bk�#^j�y%��s9��<=�#�Vn�~��!��g�X�ek�L>� ��i����U$���*��@�@�:��ϰ,�E)c�
�F���k�j�������
3ؒ)�@aB��U��*���t���̝k�xJ����r���������x84x�P\��^��.l/�_�l�JvM[�]��$Z7[���ߤ
}w�p�X/���baa��\�:���I��d���7��<t���s����$L!���a���]쾍�%1ȸ�F ���nO�r+�@��'��'OƸ�$�����{�%�ɨ�mB؋�hw�O�ڒ�8�<{QG}�(�FC��W[!3���+7ڑ2m��@Da�Rw��|��2��@�RLWu��ʲU��z���[Ĩ�K>��Ai2�}�)<Aܙ��q����y:� أ�Z��j�_+���]/â�G���ë�-d4��=�~n�����M7���E��'�?;�튊bPI��V>��Zo�N�Zw����yb��׬duG>�a7�Uԣ��	�=T���6ꙍ�E\�I�B(�6�B�d~�^}�O��|�����_�n�R$�lK�n����D^�|)�h��ӌ�,�j�G!5���fvw��;�^D| Y!�=.�rDRB�=`���d�!�(�ak�~�!�}��K�!x*;Z8�y^�`�L#�*�k�/F� .!gӗ�3pI+e�|Al]�z�ӷ���(v�ۺ.���I5<�?��mĚlV4��ﳅ| K�0%qT�ymX}�����C���mY�1hd}��~�1WV�͸��F�5&�� |Ƚ4���3���(��~1�xz���.8�[A��cG$�Q��xR�6�el�{��1��
�����u�N�Y�o�������-�Q.7Թ,�X|-F	g�^v.G�/���VRM2���(nv�U|#�d˴��ei�$���	x=�����q��(%1�<��c��Y��s��8��tf���}�"ءm��b3�xM �i����=t��N�M��8m�^�@�=���]�X���L�	�}2�}�ȵAr�jW�>�iE����+��\{����o���M�	�b�(�L�<�U�[Y<�W������в��#�]?ǀ&���{�f]��r}�_���lZvO�Kr�i,DZ�f�=��H�����ue�9,��%�G��]�����#��X��+X&b��F��u�0;�������k��L���B�x���6lA:$�s�X���u�d'9�q�l�;q�1%���阵탫LƮ��я ��yrx���z�ɘ�<�Ӿ��� f��z��� [��u\�/-�,-�T��\2��8^_ɨ�)��O/�o��Ɗ���h P�dKu����KmͶ ����Z�L�I��a\4�Af�Bx��S�ta�����(��x�_w�QZ,^Gu�Fi�q�    ��w@��d�-�d��A�T����E��g9��@��QيÍ�I"�(m���a_�U8<s˲uhQ��Y�FE�I���t�Gӫ��E�:2��oCS��t�t~��A.�_	�ꭹ�ԯ6�ǃ�y:ϧ�es����7�3(�ɹ6���o��dF�L�)��uqW�(=�׶i�dU1ۗƭ�������8j��_ h3�ݘ�:�=�,=��dNh�3�,��}[�ر"��b��$V#/���M��7�;��:m���= �ҟ�M�Q� |��Rx���\���r������/����}��>O��h_����|k��|gMX�7b:����2�?x��-�{�F������x�97�1���ך0��U�2�%�&��aa�f��Yg��xu�/�b�u_��-�94䛒�J����2_�A\��ė���`,w���xM��fV�o�N,hL��,e�=Z�tշ�xt/��D�&�m%�!U&}�����"YZs;7Ϲ�bS/-���	m��ش�Q��-T9?�\\Ԟ���:���}k��0�H��b^~;�m�����i�������e���	׈"��Z�R��>�o�Ap<�8��^ȫ��I�]x��U�/3d͗+���$�#��e�] ����U$9у:w���껋+>�����;O�G)��	��X�����/a:/��_,.��CU����8�@\%N�H�﴾/A�w��T��TҦõ�m���&��f��D�i;��5s�U�^l~�<| n�	��G�����(�H��,d�8��-Z���)�^j0Y�Sܝކ��G'ӒC�]�`�;.�:�C�a�����O�-;A&�*XT�L(z������k8�9]��~K�R,ʼn7i��r�y��r�[M�V�z�����=H�йH��O_�������qzB_��hYV��iB$y WҔ�dSn5����m���/�U��	�i4���-���<�t�M'����y�KYӂ��I���8��i2Yo�P:?���˅g�6G��g�V4�F��c"Kq)�%a���
d��8S��>��S����bI#Λgk1�[q4��(�F��Ÿ��IUd�j�<�rP�d9C�=��0��T�UZ4j ��fUQ�3�9.���.�9x jr�J�,�IKӭ3�d�Y����3Gh��?m�q��E�~<�����o�i	W�ɓ
�y�Z�j�$LW\��k5iv��(���}gT���G���x;]���9},�=��r��gY���[\6eBvE�9*��:.�\߻�÷G|��a�}�+"F��>:�Fc�%7�k�NѾIj6����>���C�<��=M�Y��\l*�!s��n���%\��N�c�}�3��G�B��q���A��+������r��+24��B�漩�B�\����JY��	2ʶ&ob�9� LݺigC���,b�ٕ��&_r�>/pV_��~(�e���eW ��`?K*=I�|���(_��_�W�'|?� `};\�'�k�k�Łh����� Ӏ�o����  j�2���6y<�>�B`�R:���8�u��M��g�����r�V^e1@�n�n{�qwE����gr�^�AR��=�E�=b�֯Cv���[��@� �l/f� ��[���$(�~C�dn�r�5��:BM������u1��$n$'�h�f@��n���!�W@L&o�hi�/��^�+\��vVd���/zj���\��z�X�z���'�/+:�����g�d�Ekњ�EY��A7�:�P9�{0����9ćQ��,�C��������-bQ���T��F{^��N#��:�yأ���$�o���f;AuC��i�en(�W�99�e�p�J���d]��uU\���`�I(�0����.���u�{
I,��X����ܞ���"y��	F4�4	}���/�)s�ޝ�˧�����ZzQodn���ts�LVY�D�����N �:R�3�c>�Y
�č���c�'��4��>L�>�IɬhҒ�SP�:/dc��� HE=7P�"2��Ƴ���C7|;:ސO+$ �gC^�#=��[՚{�b[m �m��t��8i�p|�4B�k�<X��/7�	�Y�q��K6�;��}{��i#t�����L-)uN�a�}e����ۥ\l������l���u��y0��,�d��l�k�ҥ�k�A��"ầ8�:s�/~WPS��vZ��T�"���\	>5[���P��h$/L4����nz��x0qq4�,�{�)_<G��1"�g/�M%[�hҕl�@��w�Di�����i���)���Tiuź�zY?��_�<[ �|N�Iп�L7��#K���Q>�1��+L]h�7����3J����.������/���5��'����<�t
��2�@�^/tls
�$���B�U<��Y�	G���Q-��j�d%�m�Z��?U�LW*�R�6tm�W�oMr��u�޼<\5o�+��W0(�]�tsNr��J�  ���2�*n� �۽bju�my��H��0<&�}YW%��F+ݜ�&�G������L�8oK��(�x�HO7�/^:�9x&�m���J��i���<���\����aF�kG�J�vVpT��G_�ˮ��K^"��<j(��ۉ]$}{^HJ�U�V� �[�>k�*� ��P g�^���������%~zx�i�<x/Ni�2�g7S�y���	�ST��m�5�x�.ę�⅘�$��<M����xZO<#��@eE���
I����dA{�f���Ĵ�2
��L`��}��Z:K�k�oΦqz�q�
�geM.��f�l8�G�9�&]��J�r�L�lhJIs�B9�lM.��V�G��|�|<]��t � �� �D_��_Zz���CF�7ܗ�Q�]?��8}H�:�*7d���%��N����ZQ��ؕD	��{���	 �6�UNx<�8�}���]��iaѮSV�8Eژ6�_��Iڀ�J���oP@�@F��*��d�QD��i/����Ʉ�I^��ݱ�3������:��e��  �ъ@�kA���>Y�;�.fQ���1���,q���N�]ڢ����ؼ�@I ��ƞ����ƥ�����u�G�WOo����'�-[f�������������׈k@'��j��E�&dt��Έqq_l�����^�m9�E�7QL��$��ۿq�63���Ua�YK��r�q���z�0b�?Z=]�<�+nˊ�VGk�-�K՚w#�f胀�F�7e.I�OP�Oި�6���������g��S�*�4{L�#�J6���d�����c|��=ջ���mur�����h�9x�k8�����9�ۋ�>k�4���|�C������sT��t��G#���..?�����ʥ�@1JWd[���9ߎ��r�����V��Ӫ)TH�W8�����yB.���S]~�b�u|��&�5I:!�0���,y�*^a8�G�څ���'>Om���y~f�MR�낯�o�0������7@�����%2&4~�1��M]�nOO�u�γ�,Cn��F�/r٘�'__r�Й.޵TpӇi�x��`}g���^��O��e�Xs�,�%�_�?��;Z�������5p|��	�zk�#�{���0{�cсmk�Ə�(&I�Z턀���7,����J��$i�E�T=��E�\'��]���(�)��)q��v~��<��nV�+�P���y����b��,�Uu.��Q&)���X"�/N�yr~�;-��f� w�*�"�j���ױ�$k��;���肭0�+׿@|�{�o��A@�e��-E��ە�]���D��>Ƙ7��}�~� v���pS?�;�1_+�^�eHtL6T9���H2#ȅ��H��<�]�Qe��g��.�!\�zP2��Au�X��+<6��%P}�&;�Y�Zu�6aD"U&9IL%)�Xg���օ�7��hǝ�lN=[.�0#//�]��Qy�,[�-�L���X�±a�&}�˪��?*L���Gg��V��qP���U��"�Ѩ�����k��2��+�3����������G'W    /G�!��A�K+*!����*��9�K����Cp�eR����:�B�e��[�ȼF�����i}�y|k��r��Ѻہ�o�f"�T��O�u�������Bװ{����#�|�Z另;E.��ڋp�j��{V�-D�VE�wSlz(��t�R�9@�Dk� �i A��Ӈ��9����i��h�jv(��/t��Vq��oh#�U`��k8ڸ����i��1٬!;��qL���Kd�J�+��Eꃹ�cW�'<���b��{��c��?e ����c��8\D�*�K��������rK)����WeD�0"?r?f��<bއ��ɱ�ͦeɫl!U6TExԜ-ɲ��O���()*��|�V�a 1}��.��@<G��;��w��e����Ù�����lO��q���x{����(��(dz�P��L$+U>�'X`8A�ѕ*W�2>a�n֛��b���� �>�:kA��ZYPRj�R��YWE�$pA���mvJ�+8��"�#�P�YԱu~?���7㪪�L<n:Xi���U��dY&�A췺 �y�,�)�g�4���򽊓�ii�󜖸�{�(���"_������-�kq2��*4���t\�sg���~�<�f&?E��ђeN�O�J'ܪ�N-h����w|Y�A'sH��:]k?�"���=l������H<J��\�����6��a����ϳ��h|[	=ɭ����Pb1��>=�g꒫'�=o��;I.�nV�1K(�g>:=�)�s�C�Olh�o4��F��?rmz�T9Uw��$ڜ��r�*q�gj�bjp�уAo�Z%д*RXwo/���Ǖ\do��!�88��ͪ�pȟk��m���a�:>�k����"b��,3u��I�t_s�&`{��-�L$�����Ìv�Q��R�ڵ���~�ʃ���v�whnx��H��G?�x�i>ߟ���o2��?&�e�JE��f�5Y�S���=�HI�H�ѻ�O�>���Y���h�.�vv�v�9 P�IH��Q�F�jG!y��-H����;k�0�i���Sw�������{��zǓ  "��N�}mX�ת�ʇ�K5��w�9��S�ؘ�f�߯77���~~c�|�xŒd����Y�'I��O�%Kα��R(S[��LT'��xa~z_3�g�m%Zt@Ff-�Uh	�F��KT�&(It\LVg�H���B�AD�����7���%m�ӯY���V�j�+ֈ�V�>ѫ�̃��f�Yr�m2@��?��yx.�%D�������J6�X�X��x�E	�,�!<`�7NKO;�h]h��:�&.��}y��z�3��A'?�Q�lTߓn�����@�P��k�ܖt+6$�J�YʮЛe?����W�C䞏�2<Q�P�y,�~�8`���x!���������DMr�C�ݦ	Ó�nu�4�|/�Qı.�j%��$�Os���`�k�k�h[���z�DO���Qb��@�Bq��{�"����l��$��t��֑G��6zG� �E����������/���pVF	���9Q�@�Ш�Ɇ\���Hȡ=��p_�}��3 u��g�]���Փ1�"8��8d��f�|��	�������S��g%B>4m�ձf
����׳��r�}���^�Y���^�:-d�����r&>Ph!(f�KC`o���]��}lO-~j�BA1l�o�
�R;=YR`a3�R��w^���R	Zn���Y �U�r&<��q�A�^�3����{I��t ��X�����5�"�b����Xm<�K�[��PӢ�5�ڛ�P�I����D�B����� �m+��@ܓ��D�|uӬ�`}�����Ӝ�xc�Zt��I�&JK�%h��;��	s�l��P�������x��|?9Q�� ���K2a�w�Q�@:�t�k��e��˂������QD��{>)>��|d�e��g�npf���Kݬ�I��7D~�o�P�ԅRQ%��֕�@�9�.Nv���x�^�%��~��$���av�UG�m,���U��`h|9�4*��
Q�P9�r���'�W���:��9}�ZYk��j��+٨�I�<B|��-Uo!�z��%Y"��Cwq�7�e�~��FMB�ȼ/"q��8^�NtYu��9d��Cߩ�$`0�,����*QZf}w�7�Ww��D4A��ҧ�<���F���G�r�Wi�зe�A��Jm��&��yZB��(bsh��	���L��f��'y��h�FA�f�w3���-|����画x���ۋ�f�����ՃޢuEvT��Q�&mr/垀GDta�x$�0�PUv�A�l4����uz3e�6p�]�Q��h͵o�Z6�|ҁs�I$��b� ��8����;1|e�!�3�sO�e�i�y:(�$����U�K]��1$ԡ
j��-`���������+�|loy��� �(+�d�
�}�Q�Uٻ�ك�h�iɏa�����U2�7� ��_�w�9�#[�q�"`����NJ��Jo��P%Q�)�O?q ɬ������${��[���:��L���vO��6[���ë%��,�u�Q��Y����Y�bq��l�b:q���X�RSe�A�f�
2��y�N��:���|�)����US�&;+�a�~`��+R!Ȫ*�MY��N��E��JP>XV�&_R��\��잋�g��A����o�_�(�e/hBWH�Q'��������%a�-tUy�A�$��}��M�iD0��l��~�.���iF����\�mnW��
ܻ�r��-|:P����j��I@�g��J1�'o���6��v��c�t	FC���f�`J;�A��1��cu  ]�W �<�j���>��E���7�d����0u�ݭr�ɪ^��2R�S��|6H͖WG��n<ɟi��s�O芋d���yV��2���lM:kM�$�ˢ��P��_�"R�Ȅ~��t��U��'�?���*]�r�:d�C��	��d'��7�+����+�Z� Ъ �[�%w���j�9}�Ч0��]���Ȁ6O��M�X.#��\��;d�3GO�ƊEP%������T�e@�{I���1�oT/�����p�����V�6]����-����z3�:���.$;�ZDt�ȺF��2Q'�:<w L��F2��.r2���T�"�P�5���Eq#�!4P�6��K�O�&!1�u7�TJ�;]
�	H`�<n�j��.PN�N.�������!?��!����Z�5�s��F"0lb����r�`ao;�Px��{��V˼�so�Ȏw�d��e�ZVk�^E5ߓ`��K���>��FZ�a��U:n���_g?�����j|�8�ը4�m���up���D��ȁ�jX��l����	����u����b��}��7?��:e�?�zaj������tJ�D�
ix�_vp�5�T 3�t�X��4{��h�э5|m.yMW�!�lS�����v/;���,CXN���*1����[�).���g����� �(?$߁?��=��T/7؃q�-4�!|��,��Z�ح ���%��ko&Ѹ_ɥw6�ط��O��4A�A3��Bvrp�4�<�e���%�Q�#ʁ�JKD��)�,��w_?�#�� �H�e��+1,~��:��q�DR+82��B��ESVj �f{���H�HZ�R����آ�6w��9*��,�t
�yq�o�:�2^��v�u���=��#�Eܔ/'�xy9o��r�?j5��kq҆����2��u2�D�]�O �w��g'��L�$��s�u��-���^��&%�cMh���l�8�������ٟEl��G5M� ͅj�!j?^�qS��kt7�3��V��;Ҳ@�.R|z��+N�R��� 썻�����'/g3��
I�?
�{�̓��İ���	Y� I�IvN�Q��b�*�қA|��;��v�o�s~��XS�jD_M�h�U)#�@0�aA����j�f[�%���Ŭ\�����#/_y���>�M�y�p�G�9��=AQC����P��v�$IhܛB�us[���K3��    4�Ib�W:}�2L6��O�"���c��{��dx�p��`{ʳ�N!��}�u�k�#G��e���O沓ǿ+��?��uB.1EI
�H��J�Wb��E/����S6��0���<c���|:0IwS�0�7-%�]X�� ���K[�,>ήo?����
2�4� �L�n'�!Rw��`Nz��!���g[2�m(����"�(��RG'n��#ڀ���$���d� ,PH��^v�GS� �v$kCi'���#����bֹ�Y����L�.���8�%+9�h����N>����@�H� �q�l2`����?��ͱZEK�H����Lo��V	��|��"!l�|n͑� �_f���F��/@�(҂wX���ڙ�s��\�xWXV�N7*�|Bb#�6_�&.T&7LKV����w�y<0�Kgֶ��8X��9��	A&���ʞ2�u��U���jn3t	���@N$��H�@j�X���{��8���d$�`KJ=ڜLt�P%=6�'�ʵ51���)�O��4gX;^�:�Ī=~k��L$=�y@_��N�m?_�*o!� Z�0�5�8�P�Y&����^!�M"���x~�X�)w� ����P�b/;y6��L�%�U��<7�4����m��%J�"���%*�ܷ���S�o^�hhAVR1���*gC��O=+��C5���'�I)_7�h.�blM�^-@�\�IU=����(��Gr0��#1�� B͖E�{���xn]y�BE��0*����e���Cp�KO���$%
�B�XɽюaBo�������eĹW�8����~�ͫA��VU�2����!�� �i#��W��M!n����O�m�a>!yI2�K�	��z�XȒ?�+�Rl]u�꙽�� �z���_}=��c���$_��NV�+��s�Z�6��׿�q��LT���bQhY!��)�J���!���z�6��L{��/3�ɛ>s��L���j4�����N݌�pqo�$;i3�k'G<��Yo9�N��������F��10\��6KsE��O���k^���A�
d��z�v�9?Y��iXA��<ӷ�_lS��o��溘��yA�7Y*^��s���U(��(N�F����հ9/<�z@R�>$ƒ,��¯7���S��)b�+c8�
Y�6��|�WF�<�3e(�xK���6p�
V�t�ao�y0�y��V������."@������'�iz,$8v���aIVj�h��)�����o�c���;�l-˟D�6h��/��Gv����H�Y3}[��R��cI����`�w?���%tԜ~���`����E���x�O�T�S�u��Ϡ+��kfU�f���huB8A+Xw�X6i^���a���2���M-D�$���1[tb�I���#~�e͔��4⊨ل��,�<a��R_P��K#�2%��EɪK;��?�_oϫ���g����� Ӡ��-���dF]��0ꐯfڶfSe�_pAt2Ia�k�S��v^~�ۯ�j���aW��He>�` �Na�8E�(�u�.�Z^��%�x&#"�x]h��v&q��6��:�e]����H
u!�0�p[��ɑ�
�6גV���?p� MUe;V<<?���Ĉ�6���>�B�yf81��-ܖ�t��j�,�l���!��I��^zB;Z�lgW�S^�G���4���5 %�$�Y ��a+���p(��
EZ���|9�zOrGbL�ؽ<)���vm��Y�e
FԎI�����"k�$���+�ϥ��5^\�r�z:��Bq7�1cTFQ��d� Y��*��@%��ՠ��Y eÄ�q��f�M"ޫ����qt���,�S`0�#4�M��VF�I�{�����*5��W�3�P��
k8�g��&;�K�@4rߒDa�L��k W&�$KPR��@U*P@`ڭ6
uǆ�FU�t�7�x���T߇����K�+���_gh�� ,�eޚ��e��n�H	%���������l>�f�1�ǃ��MZ�$
g���S�V�ۊː*��O&tg�����F�it�<�5�j������:���t���%��Mj����e�m(q�m�~�e.ێ*��7�H�����:~���.\��d��b���(�A�El�#d0}��H�SO�08���h��%��&�!zq͒��e��G��n�8��b���#"J�k�Gd�4����N���	����}.�����58�m��55�| �C<tu!�l2̡�S#�6�=��}�M������}��ѡ��>.![�/�7t!;Ţ%�`o`�Q�.�`RdT%��WeW;Z��fl�b^)�\�uJ�i�4�?�ϠX�S���y�%�3PMON�	{�իӓ�ڜ�w�u����5�,�r��z�z�rP�E���L���ђu��O^iR��7���߁����q�2��@�X�gg��N�TQ�.Ӕ��ݚ���7`N1 �5w���S�����zc���W�db�}#ࢧ��8�\�����+����,�6iw ��/tL��@�fN|���=�HM�ٌ�
�9���?�� c�$�� �D	��Vs:>������v�$�w_���v7߯Ɠ7^�at��H���c[�Fv�_V�	�ۤ��J��cp��NdtYo���<\�%�)/?ƌ3�_ACF��({d@\H �*
� �ׄU�9w��t�ɴ3g[_��/��c@����8��+�����}��\�ؖ����$m��}�|�+�z�E�o��7[��/�Bܝ�;ZOK�MӉ�����^��A�uL�4�	Bܞ$��n�K���L�13�O��׉�t5B"�T���4BJ6����Z���z���8V*�/�`�F����E"��wЛ�� �r#�Z��fp��Ĩ�d�������]Y>�h(�ʱ�Ҩvs��y0�8�7wwx<����*#�61��f@����P����吼K]@��߱q�{�,f��Ӛ]�H(�w�k��CM������ 9)��A�~B�c��M �W�7��]�.<���q�3���1��n��D%�Y6牓&�Jo��;T���/���;g6Dڷ �j���1Fͨ��A�s�5{2H^�E�u[9�d@�� ��P��!���?���[�<�;R�VЄ�)�-��Ɍ�D�����'�Ĺ,���%�)(��Ń�����&�~�)�zU��qۈ��������r���*��HǦ���e�Kb2lr5��=���2D_.�`�:1���`oK'�g�q2PK�2#��p�V�R�H�q��ߦ���x����x\ȗ6�� ;i�s�+~�B%r-�u��-�iO*�C�J�io
q����?�ցsL�l����eMJ=`�e�4uB��F�v�@�
XGR��Px
����w3�j{p�Il���Cww,��7$kk�"�n�!��li���p^ݞ����P˼��ƺL�_�� ��#�~l�ٲ���f�4�!<��	\����<]�T�7I�����t�|s�ݝ��. eF�8��t�mi�m�I+es��7��:,�l3�$)��@����`��k��ɏ��,�sY}�Ժ[:�d[�U�_�-��?�chfq����ߌ����9��fW��8䵳�L��x�S���{���� 'p4�2v�.�a7\,~��O�����M�)n;�v�~"�Mզ�^_
�tA!��2u�3>A�j �"ړ�����������Wtǂ�AR}&�)�޾pbJ�A�X���\ ����5�41J7X���s�u��E\q�BK�f�	:�X��`@��
��r���AQ�G���B2TIY�۔t����"����گ+k��z�y�
��$�jeA����`�̥��b"(�2<,�lBR��q�N��������l��L���M~�\��{u��K��H�k<�B@�b*`��Fbg�6��lkcٟPT��!����6Jp���i�^9�>�ݪp�!��m���嵶���-��Y�n����:Z�/���%��"��-�ARE�/Y����T�f� kʅo-��(���Y<X裡�sv�!    �
�1���I���Pv��/�o��m�;�ӆH2sp�7:T��\l�󯫢F���ʏ���T9���Bvʤ-��j3�y�UpT���	Ǉ����n��"�8���{�Y
�%�(�������r���"@�pU�x(�VW8�ϩ�"jG�e�ܕ��{�B[���l�#�b�)�]��	�d&����G��(�U�����a��O��`�Z�:���VR�?-�\��DP� G͔��g�еix��h��-�nܟ�0��(pT�T����u�9A�[��cI���}�� �=����ܡ�m���eWCo�<?l��
��5.�4B|1� H�b�+�]]���L����a�ݐ$X�z���xQ�����}{`�@�Aի��0�,ES����6��z�:��I�bƎm'�;'2�ı=�X|__論����M$�h�Q|����r%U��~����U��2J�譩��]�C�1�-��f�ɹ����8��bŪ���_Ȫ��m�Kh��3�v��Y�௽պ9��iZ���rm= �D)��t��$��H&h���4NK�� �\?FE�.{n5	8����ǰ���U@0�t�:ү�ܲdk�*��ڜ�^s�*�����e�=���>�5�ȟ���g#ז�5�
����,�-�>�m�^1�$YsW1����L˸���';cQ<T/�ś|�$E����:��p[�	��Ŧ�@��I����҈�@'D�<�ݤ�,�z��+sH*��0K}�Fv�z� #�h��m����Y��ʜ7����e���F����ip%2-�r5��e�6��7������ħ/�0���n��L�)�7Zw�j�x�Z���\��%��#҃E^�)7垀q���j�t�k���(�i5�x
�of���Jm|�Y�In6�3��r;��iMwde�*��cVSSB��3��JC�A+��/����ۭ��24����L����;c�g����g��r�[�ׂ�����i#='�I��T���f2���.g{�.D��d�# j��N���@�D�9��Pۄ�T�H9DM�����F-�W!/D��Y�#xH&.��sn�C?��%�_͗�􁣋�}��[0�n)=���kRѽ荷���D~�-w�� jVʡmq�6���⑓�@�Z�+����U��s��S��CY2�� �v.�t�˟���bJP0������6�kp��`��G\�?ݼ��R����o�d�xE�ʠ���H!x��?��d<��= U��Dz��}�l��;�H���L��<"�[�� ��RC5%el�+.)����(�����r|�����f��O�n|�@�y�meu�w!��M��2Q��/�n���n�mG�d�_�����`�����W3X>�TTq����'�� ֻ`�hiՑ*j"�W�Qӿf�h|�)�M����B�c�Ƞ���S9�x:�&*���J,�s�!���}�M�S�L���Zf×c��Fr9�1d(�t�Y+y�+w �2��H�)�. ��ߔh���}��D���s����gq�.WQ���2*��YT^ˉA�Γ̸[) Ǌ��Uo�65���I��OL�1t���z��B���V� ����8�2��@By�B(1ZD�v�v�%���M��˘L!N� ��'�Vc�Ϡ@��T��� ��D��)��*ƛ��|����@���t/g�N�7n��&;|�� 7�kړv��y��U�߅~�!�þ"��t�Gݭ�A�$Mɷ�!��L�:��	�fprO�FiS���+XDg��x��|,��t�2�ɖ�u��&ի&�B�A��f�QR�[H��/�6�R9�	Dx����S[}'�tS���hi
�`���*���H[���P��ʢ=#�_�!I�H�ws�����{�F�\p�S�Pz�L,�e�� �@j l�&��&�L�E����A�=�����Nj ��n�ܥ��9��M���S�}�ž,��}��VЦo��MB���C�SV@�?�j�9韂n����zC6x�m�!]�坼��''\����z6������P�	��i�,�y��Q�m5�ߪ,md��z:dDB�V��i�A���z*a�������q�I��('�tSY*S�T�Zp��������@7m[[O���q�����{ӈ�����d����_	�uq�f�Ľi�m���Q.�-��L:���ךK2�����=����>��}�^�>G?�,HF� xT�Ŕ�j�/$��&����`#Զ;����2�Db�l���2����M"?�[�lK�M3���i�ʏ��%]T0ڳ���"�oIM!fW��~��o��) ��� �M�m��N�MDؑQ����Q�$�gɡ��� �W��q����s�b�� ��F`3��*�`[l i�6�ؾc��ۀ���U	m�b;��{?�����<�H"����7W��h��"�����$�/$��'Rb��.6��:���E����pfؗ8G0 ���	@�Abv<˶L�(��:RJ�7$J;R\M���0j�D��ρ0�\�6U�����ld�"�/T������3��SПJ����xr�>ȥÎ����iS.H?��n��mPѭ��B��7�c�������}W���/� ���/նF7nd���.���CFk�Y:���h*~��v�,�9��/�{s"�4Q�Pg(Ժ+�0�E��N��[��Gm�n��CJl�M�ަ+(��E����v"qx����;�w�cѣB��^�P�dNT2��Um��eG�p!�Pө���;�1���{q~G��Q^�.¥�	Wю�$��j;X�|h����\��t���<K��ӌ���vS�i}��������$s%E�o�Վ���j�`3<�g�-#��ǋ�Qux�>��r���d<�c�f�ʹ���4�a͂�����-@��o͘�A����i�}�a*=���ǟi|��J_�=m�r6K�l��:�.fp���Z
�����ñ�z�-���r���MJPz%�a^�����uzD�Ƥ����� 
!�S��j���s��6{2K��f�N#�g7�����)_i �Hfi#Ȝ��i��N����i"8�6����T�D@6"�h��������>Z��B����^G��{�[��7p� *t��M��:ٓ@ա�n�wn9z?�S~<���i����hJ:̌۵������+��.�|K&"�J~�����q��V�r�{���V=^Ex���)�Y �Ӓ�t��mQ(�I�)��x4����?�k�1�4�i�Wsn�� ��򨠓����Y߶BՔ��+��
�N Fi�.6\�@��R�d>u��Ј�r��oC9�+�PGMî�U!̫��am>�s���)��q"�,��Zw���d�.o�A)�}�;��2�Gфν���s>ڍ?�����\3��p��h�f���?
SV��I.���[)�􅐤� �zS��q��^S�t��J����)�Y��͢e}���f�5W����0u%�O�#�M#v�c�W��|�8\o�К6b:A�;H}�)�g+�S4Թ�,�-���J���B�u�xr� &)�(ī" ���:�Y�.mh�S��$��]�y�Y��3]�W������r���E)nY|OH�^�޺!n����!=��I������%����n��e�i�J�!�tC�)�Wd�U�w=��B,��*���9	V�~<E�}��b��V�#o3�$�o��s}�$���_�>aA�at��8*	BQڱ��*����!oB�T�,�qm�����o��z�%�B�A�=YY�l��OV$�z����:�?G���ql���;R�iߔܮ�_t!=�{���Du#���e��6���,��=#N�D���l���9Hw�S:]	@��&hdg=k��Pk�;��V�9�B�3Kh2�P���t��ll�s���,���c���l=����xt�HB���g�0���HaͶ�2j�4��J�����x���	�Zp���z1��RB��兜�.����s�p�\��a
1|:�rI���o��)#��N�b#����2 �	  �HSё*oĮ�[���yy�ʚ�ʐ�(�=EO%.�Uk˦�u���i������-��V39���|�R�4܊���0>�g�yBY�r�M1p�֫6�֤g�=d���O'!�X ��)�>�*���|��G�I"D����R�KS��Y�+�,>.k%k��u�p��t�T��2���wu�v�.b~�]!�V�;��S ��sԂ�e�մ8�@*4.I4f�&3��$�WR����k����,�t&dE�x�<Py����}tQvO�٪�엠s�(k��ގ��޿�٠$�IJmP�M�2�[��ɶA�;�S�V��|���d����C�
l�@%�к�ĸO�g��d��u	�h��A�QP�u5��`��r�2���@�k0h	&˴�ު�{����q��#���c�؃yI���zPG97y�Tfd�{l����ti�KJBE��������컔ֺ�:+�\�o&d��|��뺇4��3�^���B�����NN	������X�oc�<��ޕ��,9� ��κ����1���.21�n)2��j�7}�w��n8~�^-��a,�u�gE���dJ�m�RF�7���02S�$:p�鵹-����uܦ�%�Ƌz�.�GW����!��6Hפ8b��}
I��E��c#K�(BQ���5_�{u/��YY,�W邠��m�;�,�a<Iֻ�\P�&!M�t��p�.HT5��,�?�j���=���\��d�q]��:[��zO�#��*���,
�}_ë2�K�����g�7�5�ƿ07���\�b�ĺ�#R��v}U����� n�h�.����W�L�CE��N�c�<���R��U��r
���#��h�T=�*k�*;���238�@�}���4���{�)�q,t�`���=)�@��r�Y�6���ܛ�t��}������*H���|F7�(�����绿�/�g�.�N%�=�/�d�G�6~Ò�n�@�62��i��z�����м�Ș#�"!���t�$�X�nm�^�:�7Cc������aF4RG
q{��J�k_��x#?�^`��"A�S٩�V��%Q��n��a��)N�ᯜ�n������o_.��\f3B�K�<���,���!r�`qe�z���vI� ^7�ay������zɸS�k4w\�F��Lvj�+@�f���2N-k7\���f4�`�`Q�ܽ]���y��hh���/��K��s[��}Y���� &B��7��L���I$���d�B���ID����4�|s����B&���ҷ!��Dwko�D+:�J���Ɋ�3�nK'i�m��~��+�o�Mi�H�bh��m^-P}��O�	�B�UXl�?j�Gqw����r�ʨ�(ﻮ��י/3d�)��D�8'̆�ԁ��љw`ĺ�Ե�\����ٞ�X���C������{,�dY]��#��9�d�X4�S�}�MSV)8��l$)��;{���n��'%�D>�+�)�oq���:s[G�K��{�=��'�vR�vqZY��+�>�rH.҆�R^���NI�R������ǈt�Y�K��l	NΛV����ks�?�ʴ���M$�:�����h�x�H�
�P�L.�F�t0���z3�9�,��b<�
CHņ)m���H��TL��z����f&G���b���U�f�9���e1��YۙLC�����Ղ~��ƺ['�K��K 00��Z6�>"L�j)�.����z�[��ⅰ>�Yƌ�իg:�2�V�G�"j��:-�{�ҍ�&�L��~.��oDs�v���e��n>��b�G=�%����������>���r��p�0��v��].j!�!�r(�N�&�,	ի�}�j�[d�l{h�V/�͝�"{	ܷ�|��΄�C�["�W�[���`w�ェ�0T�r�8$QOޓ��֛A|LM�r5G�ġn-�!�7��n���H�>X�xz�͚;��t�bG�� &���^�w�`oZ#��̀�Z�Y���j@zp(��.2�-���Re+-:����?�x��Β�"�:rMO2���t���Gh�#����-��k��6-S��WA;V��N����'�(�I������"�V����y�p��q���Iq�!ɏ�:W-9X7M�`�C{�%�V@��P��/R	R��u��\��P�eY��m�A�[�O�k
qx}��fC�l!�$�L��4%q��Jw�O��nIu�������d���ǝ/��b��]-��pX�5M�>;��5��s[W��2�[we��,��,�51�p�ru���kc}�����).��v��5���G��$ւS����Z��7�m��&u��FO#��[s�r-���,�=��`�u=8&(K��TI|t� �e{�z4�����mRp�s���DD�:�Vp�� �@�Χ�"���0$�:Q��~ U�k+�l�g%H
u�,��뫙������?��?��?�O      H      x���K�7����O�����@5����x�q;��^h�Z͙n��dkF�~�(�� �n݅b
Hd����~�7��_6�͗��2����~�����������?����?���=nr݇��?��wo�w��q����?^���Ç+����o��]�	w~;�W�{��e�ߝ���y��_�;��޲������l��|�6��)5��s�������ԯ?7��n�;��+����?��y쿏�����]����~���͛��s�~�u�<}��}��s>��9S�����p\�x�B��/����n�e���w���o_iU��v�����<�B����9�l�x�*vO���n��O׷�\���x�6�/����v��ç���y|\?lw�'=O��o��49�>�˯���&�|��Iÿ�4���~s\<�Ϛ�;�׏_��X|q>��>>�h	J����I�R��id'��cV�u�v��:���_1��41�n3��7|�����=@�������EBC��.���TGu��ԗ4��8Η����2�\�c���	x�_v��L�"V���s���:������ wRw������xx^?��ie����p�t���2l+�|�\��]au���S��cx����+6��o/�����9�^��8{+����[�z�O��a�W��ӆ��n��M�����]V�����G��}���0f��� �?n�O��×4��d�0�Z)�Z�����w�}�ʈWo2������ �H��ݏ���q9�Z�8��'h!�<��I}�����<j���j��'BE���_�N�|_5P����P�0ٛ�7�m�I��i�N�k�>ᚗ�X� j�A_w��>�b�5��~{|��jRv<��I�Qٳ���V�6ҪC���6�����m&�m:n�vgL&��܆a�D�a.e�n�����>��������=�g#1��'�������0�ښ��zi�M��VS[WU��B�n�o�C� �n^����F-m��aa�q_zi\O������u.Z0N궬��Y��9�������;[Zh��b��S&��.ȺJ�ؕ#�xx�����$����m~��)C{�����p�Zo������.�J��~�4=���X�"5 �!Đ ��H�Kȩ�Dғ�� ��i��_���a-�N�=��.V����������Xn�� ��
�\�e��A6�e\��l5u�`�p�߳��,p*��)��3g Iץg�(s2����<o#s� ���{���h�D�0��$~$k ���O6�?���WE�iҢ��j�O����u����z8�简	\�AA?\���߾`&��P��@��H��S�B$��=��!��G��J���LTS� �\��h|�e�M"��� ������ �
��	�}���Bp��H������ͱG�N�h�d�Lkd@L�J7Z��c�`S���2��B���N~��;ϥ�j�
�/��
7`%}P��	��s�H��4��PU?���q��3}e�P��ͦAZ/�DI
@L�J# ���n�L��7�Q��^�W�
�L�ŕk��zlj0�I�\)�Ҵ@SS���ry���Pf�.�t�Qp���ٚ�o@TwD	pUEƪ�q���{���8b ]�Sk@^#e ��0�ʗ]�,�X��y���~�|~���!����W�.����>n�]���Ϸ�y�s���]E`����񗭄���"��5`��9��4P���gz��0�fĪe�� ���y&�Sb׃�w=�(��<�+ ս� a�1
xaIMq�	�CkuT���Z!����������jN.W��pe-����45i�#	�<%M?�6�ET���`�R�[@S%�mn��i[e���	�a�-x*�:�bOM�Ԧ8T�����4ZPU9�hU��VM�d��);A�0�0��X���*�V��, j���jnN8JLX�SCP-�I�XS�M,�I�n�I��9>�姷��t��ꤓ~'e,8*�ݕ�w�=��jհ�dN�D�ъ@%�h��kp}E2ֆY�4u*ʜo-�>~�T�ܲ �l��F�dS�iJ�؁��'��}�.gA�p�uɚ���z�<����t��z�Z/����,ye�+�p��v7�l,|�ଏ�`M1��;�1o��m�0�� ���D|ѷ�_���Lb4�(�TS�X��,^$�Y,0��ζL�-��	���,�n5%LX Н.!sk����F��!�RR6DYPS�����f���	'�g��J�9]%`f��:�@����%>5��tg,�N�S�mv��J-�;�ؙ��������=C�S��2��[��ԝj�Ȳ��(9 �8�������Q�.e�2�픭e_�'�%ȳ t�9
��䙩t�fN���q�ވ_�o^��4��nHN�*�&NӨ���X�N�;��8�5pFU�џ�z�LY↠е�2����*ch.�̒1��p��E��2���GZ1�����Y[�+.��ZA4g�൛Ri�t`��O��v\y�f�%��(�)2f�U�ե��L΁5��p �kUȠ'��tz�%"T�L�JxsN�InL�ͯ�b������ A�oV)�]H(:��']���is ��X������9�㹮� I�� 	9*|��<NI%I�IK�J�mqDU@��P����,��P�MhԂ��2��F�S�PΕ1\h��]�j��q�(-sQ	��Ŋ-�S������|e�$�n�q1**�K�F�s1@;V�S�.BS�αik.s܎�p�ˊ6�$\-g�q~�-?�p�x�W:�t�25r�J>�+���^yIgzEe)�
��y�l��='s �-:^7c�sS^��d�WT�^�҃~�4_�?���Y���Z�ǃ���i	�7VJ�z�������K,p�@�QY�S�Lpl<���ݕ���]=XHP�^]�ADR햷��}jEB��Vj�M,��vVE�SlG��@��>�U�!��$�>�"�����F\�.T�n�bV/��DR����}b����^�z/`��D�5j[<��\�4���wt4�
��䉧�C��S��'i�R3��I*���	<��ω�x4~x���_Z�g<`ga���t|p�J��ӣ �q䃀>�9;4p#=�=���e���[ݭ��||��TtR�n��P����\3ڗ��5���z ��������
z��ؗj�[%OX�ڔcS�Y�м*h���t��C�m��f��=5���]I%%TA�*�[��$�"c9�[	��S"?KI�!��-�e,�R��8%��æ���O%I:dJ���ܶ9d�h��h�܉�TO�n�����PJ $ρ��E$��M�@?R�4�E!؊RU�,_Dv��P/�L���,Y1�L��t�)XB�o [14$�n�9%�Rr�2!w�#�(VS�᷐+]3r����t	�#]
�C�u�8�������"O��# O�%OKb!_+�#K�'/�0q;��D�:���=��������%	��)䉪;��s[�AUuB�S0��
b}W��择��Q�,�j���*�_u=yA�_���� �E���$'� EB�#Ų ��T~I��l(��P�N����'6��B\+�'vE���%�Ҽ��8߽(o#.�I�-���b�G�ʔ��A5��*�A5}�0���Q	*��U $(9��B�.X$�b��?�]X��uA��-Z.�	:�3�t���'�Qy�O1-����I2�-v0�H0�O��	��`D���5 A����J!�����
5�\�R���[��v�<���@\��*�������ց��j��L�Ԣ�ʃ骛��0� &i�Qp��#�w��B�/�zro�E]I�XfW��s!��*�F����S�
^,)Q�1F��i��W��� �R��G�P8�L�7/D�x@�y	M�21�U��R'-X�t�b�z~0 ����BhV�� W��@e�.�p��!�ϸ�����z�4ĻU!�<D����	�e�_��Q3��]/�W-/DqQ�b �  =7�\e�!��$\0e]`9��)#�+ݲ�:p5�b����Q͝��_�N`T��"",����5SPb9�'4�MOE	���+�Q��cF9U�4�u#�n�zD�\�Q����Y���q���*0�
�F5�hjg�DS��"@� �h�-���-N� �X$�PE�t+�h�h+�j�bR�)�m������/�A��]O�S�Sr#�(�
��/�pF'%�"��jh�3��]t�6��f�\b�m�E V�U�������0^t������R<JX�C ������t��;��[��8���0��J}	�+��'tV�Te`r��d��4/:��0��߁P�n�~$j�|��K9�J�-��fK)��i;������1���xQpU�7U$�Th-G�b�YD���ArbT3��`�̈�(n���
�?Vc�1m@�o��������)FQ)Q��YE.�߈��l����e�ύ\?G%��]y�� ��uۀ�Y���a+V��{�T�4?I�^���$��Y�K�Y��/�"�ƀ��T'%�J��g�O�Y���C
�3S9����'��"C�Z�C�z�G�N�a�b>�|������(s�ڈ�+b�+�F�G˦,�a@K]a�TI���.N�6Izl#t��	33����R�ͪSٖiS�b@%��Y!�vQr���AO-b7�}�	�p�-"���z��*:�N�9gCnmTW��m���bȑ}5��^���V�3׼|�!W
���x�>��r�}��s�c1U��)+PepJ��d*}F&�Ѝ�,�`@��R�lw��rʜ��S=}� ��h��T����x�>�QK� ��t���{�}|�q,�>�(���):S�43ErM8��GI���7cͱ���X��ì��\�l21��%���i����1��0����V���43�;\K��\�3�j�j��~��J���r)��3՝rK�Q?���}$�*������??�V�tqü\���C7N.T����)M�"EK('W+�(h�Z�R��D���4Fȵ�O�4�*���f�]��B�����v���ݼ�*����b�ׅsߔ���-V�Y\�Q�M�mQ��kԐ�Tc$ŝ�R�����Z��M-*�V-�ͩ\���jo�׫��s�H��b��.�EA��O9��\�B���)-&�����j��1��      N      x��]ˮ9r\K_��A2�,�xk����q�@p��;R��� ��Ƹ����#�G$kڗVꗆ����2����g����?�����_��۷��������o�������������������7�������{[��o�6b�땃�G2�~�|�9��K5������>��bM�P�L�f��q�I����u���?k����������Z�WuwV�a�t�m�5���Z�\�t�g�G���5�D���&b=~y�D���V�鴄��;�E�4�{���c�������F��u�)��F��&@l�� ��1������:���U+  �hY�?�l��<3%���R�� ԗ�����ՠ����y
aE%��}h���u��	��{k�f���A_]lIK�]��]?�5�^ݑ�R��eh�;��h�QW�@]0\[�G��[jЀ��r�ɗP���q�������Fg�����3v�/�]�_��l�.��>L��Pg/���bKl�NMN��.B]���;��͇��?��?m��q��4�V��^x,+ϴn�����R��<�z#�X���' <׺ь���T���d^Ω�"��K�����_�6~���pQ��8���;�s��.L��R�����4O\�Vb��B��]����Q�9-��c4Xѓ�Ƕ���Vl^�-���3��7�2
�=/�bs��^Qe,��G��w��/r�P��٭��.2+z�s5����X��h��h%Xљ�?���|l�bs��}��N���B:
�s�8*�K{/�s��3n�U�Q+x�#��>v;Y]�Ӄ���x�~
x��0���!3x����u�R�9
���w|&�\����;��@f���و{]Nn�๫��9���.�s{��xi2��]�㠑�H���b�N�]�x�]���r�V�y9����/�s�`������t���Y��̠�(x���+�[x�]���-�.xn>�tO�c<�ƻ�p]��d�-�Q�k�h�x]��`cg�s�rF2��fb����+�Z�b��'��K���6/��x=@]�ܜ�5ϴ"�$�6דG�z�����*t��g�<��U9�'��3�?�G�t�ʞx�-��~yqd�ϭΨ�L�}ϭ�w�n��๵a��������"��^���๶��3x���q m�<#�Bwc{�g �Y��.��S�me7����<g���b�xΨ�63ʲ<g��;ly�������v�j����޶����Y�<C�7f����!˫��Zx]h��s��Z��2�3&x�ꣿk5�U��xׁ�����>�λ�9��5���{�R�ݑ�I���>��Cg�����}$�o�Vo�PU�J�>&~�Ũ
GQ����X�rdt��V�]�G6t����ڍ]�5�&	��5<��z���n�Y#g^=�!2��
w���Ɍ��v�_Gw��G�9k�O#e��=Ȭ-ڣ�r����!40+��;*7�S��e���`o�
�k��/E���1v�X�KU�+��A� ��U����r�;��mU��uE�k��e�CBE�.ZT�&��ȧ?2[�_��`7�p��-� �Ȳ
��2�})��#�*\�j�Q�
�ۍPw��<]�`�o�K)*}u��αe+t��nZ��� �.�
��7���T�9����M�nX���n�����j{��^��G�,�j)�{]df �Y��b��{�����A�nϙ�'f��	�3�w�P�'v��/����:ɷn{�mu���B�w�s�"�;�Sx<g�sd��w�s66�$��xΨ�Fg� [���j%��r|�̻5=U9����w��[<g#}�������llʝ̆�c�٘t�.y,�9��Z*�A�-�vm�����	��k�M�m�c<gW㝞y���^F�GK�ԙ<gW���v/�v�d����>C��>#`��8��7��3��k�mO�-yF�9���������YK-�	��lr��e��`,��VW#OU�I�sFu5��؉`wrM�t��<gә�u��
��9xu�~�����je�<x�&c�2����lr���>?D��`wq��T�:c��lqm�Ξσ ���>�}���h<gTW�[R�i�N'�|)���s��V��R����5�4R[�|��l]�y�ҽC��pOGP,�4xΨ��6�E^]�\/[M�rd��V*��;j�����L��W>��^8�@���ʀ�3T�:}�.Xy�Վr��Nu��)��[<�c�����\ϺEY��;���-�P��
��TW�}�إ�6�:�<�+��=���<׫=����L��ze������uӞo$�Zv+k ��#�Zv��;M�j%��r�����`7�j�V��B?��jFN����������=
�@ߺ۸�KE]�zcY}��������`7��m�ĩ��Oc�z����������F�%B�z�<C�̉<�ӽ���I��
�@��i�"��t�|���)�#pH�����(�g?�TW+YU8��f�N;]Rq������[�#�Wإ��s?��c�~�Sw�h���~�S]����_�:u�Q߫������SI�����#�*�_����u[˾T�zv�Qcmz3��sgfۜ3�
�۹����M��}���:�>#`�oyυ��4x����7=����7�����纳��#������<�ݹ3��7v<���;�*�|��s�YGV��X�~�g]-���`���{�xv}�MX�)�4x����axA�Nu�͊���@�]���aC?г���G����إ*�~ۃ�z��>���H�i�\�~�r�X�ݬ�q�x�+���c<E�vp��:��]�;Խ �\�~�M���<��c��깠���W��fV��{m9��O�w x�S]m�	��<�/���&݃���W�(2��$�~m��D�Θ�~1�ާ�@���~�����V�s�b�nlP��^��-�c�{��3���z�#�����}����>ۃ�q�g��>Y{^��j؝\������ �s���	�@��ը�{0`w^�.�:��s}2v-� �������螖y<�W�u��' <��w�ae���:��G��
��k�3��2ׁ���z-i�eԁ��ޯVx�U+���Y��������En�;���~�/��m��#�\_���Ƣc<�e��<=*�9��/��d�C?�YW�(k������T�E��s��j��<���S���s4�#��3�+���+[~7���3'�9��"Isr�0����jZ���; <�[�ڽ�~�R�9���-�T� �[]�f��`,�ne-N#Š�:�S��-rЅ�����h�����^W{�U��xe�5�z�C?�TWk�Q���x}��Y:^B?��QG6�h"����ǔY*�����Q����Z��0�y��x�<�eO5��u��ua�|���'�@��o�SF� V��o�j��V���92Ƌ�ޡpc����<��	O��jإ~����T/(�nɻ��iٯ����7A�>`׶�z�Ke���֯VHa*� ��фEY�p۰Ko��c��^W��g��9�#k�;�^�rA�t���j�t��?r����vp���j=�~2#`�o}���!cgŷ~5zDgo���HV/�� `©�63c�<���ߥ��{�sgu����8��V֧갡p�X�dFI�_�s�[�;�&�uv�w )��=����4Ű2v�s�#�7�<C�<�j�H>Z�;c������w֞߹æ׏B?�c{i��#y]�sN�j���#���}����aO�r������7�����H[!�x���@J'�_�s>�}ʆ���8��W[t�<�TW�ۋʺ`��j�o�"��w ����S�9��&k������T��� �g�W�ˉ`�z���*�~m����i���z~A@>��9��-=��e����b���L���   s>�6Q��O��;��-o�~�'�Z���{���:2zX���s>���rFr^*�>����=� ��֯Fߕ8�#`wr��vZ�xΩ�����~�s>7ޥ_���s���H�-�xηw ��D}F��j^����ŵ	���xη��$��1�s�u5�x8x�"�����H_]`�UW����(����|qm����{��9�~���j�ύ���Z?Y������F.�n��J��Po���Q�&�UK�ʀ�Ϋ��~���F�td�ѭLX�c�je���t(LC?0ʣ�a�xn~[����F�	~�G�_�s�r���j�iύ����Q��{����%6��Wح�2�{���.}����������69�jح���̬�/�uˑ��Vg��Q�ߥ�P���h��E{�`�m=?y�;����I�i��~`lu5~'_��C?0����*B���6��Kbxv�~�z~C?0�kl�{s�uύ��ϐ���7I�F��}��0_��B?0��F/N��s��Ț��c���W���+J�[���q@���F��A���a[��HB�k�3�+U:^�]㞟w����[K+��1�Au5듸�TWs~�M�X�~`t��w<�����}|���j��[�i��� ���q$|0#`7�j�����Au���H��V���o���l�aF�xw�q�pV���M������w�+E�K�W���|���<)o��>��7��� ��w _��Q��/�A�W۸N�c�~`P]���y�=��p~���Q�������G�9���J^��m���g�Z�����֯F�Θ�1�g��ɪ�.�;6�.�t+��`����^����e rd�����`��z���w��1����2N�.xn�]�*��๱��������;�dE�xnlu5�2�y<7.�3P��� �kq�zsef ύ��[R��j�qqm�;�� ��}5�V�u��qmz*��V���o� /��1��H'�4xnL��1�; <7�Ⱥ�j�X���z�w^�	�����(l��	�ܘv3���.��g�� �TW�X�"+�B?0�|�az�C?0�~5�r�����U��rPA���~5/w�k���ߎ��XF�B]o:ׁ����#��$��xn,֞���	�����6'D��.�34�K�� �����&�c��@� =����V�ȻQ�a��__�s�ϴ٧7�����?~���~��/;a�kT��wn-��������������,r��      L   -   x�3�KLN,����4�3�2��LΎ�IM,K�4г������ ��	u      T      x��}]��:���J+N���������n�$1���%����·�g0<�ԂZi������?��)jm�~����?����_��������������(������������"�
�O�������f�6=��I�_�$���Q�U���������)9��twl�s+�X�C���/�?�F������+���y,���_�y*��?c�}��~��-Z�S��l-9��ca���G<VD�E��jrl��kYdc�}�`�s�|n9��fve�ع��}��`�s�}.��5����UU��j���2w,x����}n������,�Z��n����^+�1u�K�����:��p�[��jK5��b�%P�Sp�)���}n�`�6���?����)�ʗ�濯���m��
un!4@v�OUh���� ���~-��Ss�ϼ|X���R3�]kkXc���^a�ߍ�ΨwggC�e��7!�Z���Z.���dߴ}Xc��<�+;e[13�2�
��ײ Zyʶ��m��*�#���ʊZoc���[8��
f��B�?���R�cY �=��be�!����cQ=n���B0��_��#5�n�fպ����yc���Ơgǖ���n�pt@���^W6Xc�LC���3���e	4���+>�� S0���!Gg�`f�#��ǭ��4�.�4�W��h�at��(n�k9󥲝Mg��T�v��wT^�n�LC/��S�)�3@�X'�k+]��e��S���N�a83�8���N��zh��/]��o9�[�����"��y,�b V�<�A�jj�o� ��:�K�+�ɝ#鱄�1 ���Ϗ����n�̋զ��9��S� :E]�׹�ivi��;4����"�Mh��yg����z,��?Lo��� ���$-��X}ů�c`7ճ�Ic��y�mi��`iW ��!K����z�). jB�v6s�]{��`@�*v�&�(��9w�ҁ, v�w�����ocq��+��B���&�����*�&�Z���V=�E ��;V��\�~�m��d	@04�U�x%���\��t�E �F�T�����\h�.���GC�i�Κ�����\;:�% ���N���� �O5'[��2�q�/W\#�ض�}�$-�~|�Y�cˎ;=�Rfge�����W}Vwg����!�E5�����+u�+X�l�uK�]�&7,����#ώmC������/�ah�4�"8��NL�	���N�6���<O�J��"�^���خ��e�p<�;��Tvg�,s\���������ag��j�ٌF&\�kR��<w�s;K!�
ZlI���	���S��[���o�JC��R�(X�	?pR��Ӿ4t���=���S��&���Ѹ����`P�gc7B��y}
�ܥ�]���K���&��2���r�Z�� C��߳��1�s�\�)�1XD��m���n�f�F�rm3� =,m7�\$ML�:,�����($������m�-���j��?�N����ʲܡ��8G����6��
�"��2�H��gkN����v��sg��g��e0��]��qYZ�U�9P�0Y�G]�;-_���kZ�F��N�G�E�i-It����K��&K`�z��'nI[�qA�=�E0Bw_3]�R��յ�9S��FH/-��#���Z��t�,����ǬLJ)�9��M��ʿ������/m�k�b��%7�?m���v�Н���������ƿ֧�y���ʪ_�%}nz.K`�������ta�f���|��hJ��T]s��}i��l�MGb�i ^���[,��0�v����%������.mk�bL��{�H�����I�v�,��3�B��~kY�Ƭ�B?Kۋ���c��&I�*Y�f�a�����+~�[-�u��E�28g����e�D�-��N�YrS��"��ſ�x��UDKB.�9[���,��jO�@F> It�{��B�=�����σ�؀=SKpu!�u�s���v�|�;��\���/�2�_��c݅D�K`�u��ƪ�W(�h(�O�s������\�ze��*��b��gX��`` ٯ�;�F��4WfS:���Z��y�_3�^ ��z�{c�U��ZA��Hc{�FKqX���>�m�"S�]Is�/V�M�a���܀�m���k�ɒ\����Ǿf����7�&g݆3D��ww�ù;k�����*�������M�\���F�|.�9�NW��v\�-B�ĩ�3ƈ�B�#�4�ݾ���3Q�ʵ~���/���k��Y�XVVT���3���M.ڲ�e{���w�K�%�d�r
���Ĉ�{LW��a�y._�Pe���b���B6[D��V�>��&WC���� �:H�� 8�>��B��6�jaU����2w����_�ĉ��ma��Bp�oApcu�Hږ��v:�@�L�UM|.�*rw"�!�>5ͥ}VY�ƪU_�6s�H0(�)X�������'�!�*�+����&�B��]ƃ�F}}1ju1~�N�9��sk�p�غ���)�*���&�B�û�e�Oz:���	x,Ո��^՛jZY����j�����UO9�a��h��[,��lq-X\���Icr���h?���_�^��r����/6��R)w.^!-����|n��9���=�Q#e�.�����qn⮍u�$���ɑl挖�u���镴Eo�l�ͮ����=A#h~���X���a�lm=�讎ey��U�T���	٥@�9�&�s9�Y�����5ξ渂@�Zc9X�lnO�ȸ���*iӳ��`hIlo�U���~1��J�c���>��-"G�Y~:fKǣXc�9��q���K��?�{��ݑ�wZʪ�INi�7��C���S�b��5�������՜L>�׆g�Ք���er]!-�p�9X��\
�� �mwy�s���h�۫�� ^ݼU"CIʊ���lr"�-���G/��*���Fn㞇,N�SM3�(nBȹ�;�v���Hoe��rk�3�U��&hK��ꦺ�ʨ�:!���@�ڧ(���h�"\��\��+�1�D���A��'����bKN3?�5���IwՉ�N%a�_tQ��a��M��ǣ��K��v|�#�.S��An�b�|�����Y��Ay�bՒ9�w�]���O��#�����v��D��@&'�Ua'�C��?%���3R|�ֻ�~�	��/J�qR�z�v�
��n���)q[#�%qv�'vv.��Q7,��`�b��������է�[�2����̴Z�k��QH*aG8�|=:�l˫B���2��z ��U�Q9���࢒���g�� ߾]�i�?>�.�Jh������\*�$m��ETIۆ,�kW(���u�T�D3�A�q����*��v���G��`w���%f�(�`�7����$��������olqOlɸ��z�i#m81͒��[rcad%#k�����Ĩ&��&綘�L^ò���\u�!�m,۹��}m��u'�U��}e�������A߮�lq�K��5wh���,	�lq#X�B еy?������+�g�O3�������o��a;��"��7ɾ�f9�d+����F������U�g������Ę��3x���2�p.�]���vM����\�c��-�\lp�p�:�/���
���|,���O9�#���+�58��^\D��{�b�̖���N�%eU�bC��q26,5ߪ��"
�M�lrO��� �+��N[�#����7C�����(1\��ǲ��`p]Q�+�xu˧��,jp��4�;��̤��f�}v�	�bs{"M���ٟ%aH�9��fn��mH�ۅ�w�z��w��
�[D��II$K���˴98��?f��r���J�-d#qh���X֨����JO�<Za���PC�E3
��u���N��56��+�L�^���1�C�w.�3"Mt�� ���&�w���k�.;ߡt\fXe�~��]�W�Ц�x�a����E������Ǿ
�yO�f���Ф�    ��C@y���@	�S�~Ͷ�k�s_H���%�jV"����V>����%���N1��D@	�m#�G���2����Q
A����b��L�M�7�W0@�PD@Qwl���O�_,Y��|Q%4L�AI󵼶\�j�a���������!�!�`� ��jo�Q��繞���������ׯͩdѫ�@�4`T6�7ɸ<%����?�nlr5,�uc�)�ǭD��f������@%�k�jL�"��.%mp�H8M!�����f�0j w���.#�$ɹ�+�!�PC��Ɯђ��'��>�����	ڈ/�.���B���3�k���)ά�f�r	����-��k�~��J�C`w#>p*�6���4����X�Q
�I9�`�ka2ж�qPH�N%�^E���Z�*��.X?+ep[�
��h�U��U���kl6�S��Cx#��>eۨ�Sf,��Hc���F�B�dX����/�ϱW��pG@���m�x�=Áą<Ztp�,K/��k�eǦ�V0�Q�߳�H������z��]W��2�և�n�+��D�Н�7�a�[m�>����F�_�Jڝ��,	�{.++倍.2�l���dtpS��KB"�5���aPӅ$gdY+�n��<�`�)
Ԩ�=kn�ꞠT��J	ުې�xkE���W1wgﲹ����\Re��B$����F��%r�C-c��4�0I@�*��i ��p�j�6�&,�6��,H)@��q 5g	lrP��)LM[H�&(��� ��6{\�-�����j�Z=�lr���m�5�>�v����4��൨;Y�8��T�U��6e|��Rz��(m�H�T��� tPpc���(8�-uk�V�K4m�b	����S ĺ�|V3m-V�<pI
��E�vn᧦�鳸�=�\�% Ð`���8�R��p��o7x�<�'�]��$�Ɔr��ƃ�lx�5/f��j���̕�����b6���u�`(�,99s������q�
�Èb!�5k*^��A������;��p+J�{�`���Oh�޷U�,J�蓱a8���Ow!#PecI������>���7̂�>�n��u�F�J{�<�'��:j=%�������EF�׸~��3U��C�&�B+ņ�����hZ�.�PM@d4q𩕲�஋�%@�����'����4�Pu4��M ���يF �z(qC���l(�t����ا|�s�����^�e�G��gi��n���A3��"���]���[s�5`i�`{��&ʞ��n�(bJV��������l8]��(��JG��:���m�5p�ה�E8�0QW��sF���R�K>=p�X��ᜀ�=i��I[�9�̲a�!��Ğln�s���`��$<�W��t��O��J�+[k4��'�0^�K��R�g���ѐ�!��&�{IC�Ĵ���NQ`ӳ���a��GZT�a����D�IsuW�>:���;O�I��I'uLRt7풄�	�n�#�鷔��M2<7Ͼ���k~W��0��!Y�BÖ�!�����q"G3AhT�zZjq��i��{l�W�2)��Km���"�ɶ7A���e&�E���"�1o֡�p��y�̰%���hq+_!N��em��b��a�C��n�{j�ť�b��D'�b�LL�5��v.[��y��嚔�h��lr+Tr��^2�N�&�n�o�	X���ݦA	���`We�j�!��¨��#ZJ-�-��u�F�'`aT	{����HkS΂u-J(`���Un��К�l�l�-ڹ|�z-��L;��U*��f<w�����$Ty!�� _m��tcB�����d0p�P`y!��Ƨ��y�$��|��(��Z)[<L�"������ܦ�9�dR�H��;�P`�+���IO��>��V>7 �`���GV΂#�X:�	,�s�w6��FZ�9��j��O`y���i0�,��m�@�%D9m,�C@|:w��R�C((0�P6�2"��s[s�E�;	FJ�'<��i�ܰ�	*+V}�yi�5�s�#��e�3T6��Aљ��	R�t���ٽ�����=g��/̓��@�:��	�=ʷݮ�Ҿ��N�\�llr�5%����ZV������6W�͡�T�ȁB���	���蒂�Gu�OjB@����3�d�ҷf�6v��<�BA���D������ͽ76���rcwW)u>�=���>�m��<ݦ�SUV焫�96�'e;NV�ܭ��i�b�0P`��q/�
�`�4��pP`{m���R���=\v0�\&���V�N ��rg�{CP��#����:�u�^]g�{CP.���Ӎ	���&m���'��K5�!���
l�{B;jț����'�
la<�w�w�}�'>ڣE���C��[���H�H��joBC�o�3�bw+Ll���e���I��Y36wz��TӀ���H�.d���޶=)$�Rw����iYv�$,��\�� ,_��7�Ƚ�����.BB���r��倔8z�G{ZOH(��Z��޲��[�ַ]V"4>�c�Ϭ�ϲ������CY����֝2n3�@x��p�W�ǈli�s�BB�oƓ{�钮��߱tz���R��?�2/�t�%,�u��S�����\���]��/{SB��u�g6r���?!��'�d��w���2��t��
��'����zI%?w�c��U�	4G��v�S��IW�(�u�u�-���V4�-��:������m&;�M_&���9������!$���-	8�0��]�%��W;��񵜊{b�os����<p{�`�e��⺧���
�׺��V�X׳n�*Z����mD��eHg�����C����oc|>�)��L24�C~����w�&<Q�JL��;���nW�`���)awdf�1@�L�=t#$�/��%-ݥm�Z���ߋr��mOZ����
��������l>�k�>��=��;��E�I�7	(���������`{{"N�.�9�J�"�p	�"��)��n�4c��D>C�	�0P�r�,�5_stsd�1��(4N6)��M���a ]�}�9��d��d�����:�N�T�?��ʖ�J�$�4t粽E�	틃�ݳi�=�t���@M;S�w�\�r����������qGrLǺ�yF���}B	�R-y^E{Sw��E�[���오��P
!���1�	(�ً�2~Q~T���w�6������h�"K�&��x��n���b�c8vZ�>Y�FH*��t���c�rI�s�?0�����t��h���
Ey�����,s��PP`��bzz�qe['��e����aU\���P�=~r�׮��gs~4��z׋-�9i���S�Tw�K���9���4�D��'k�-���29}�&�>i��$آ�����R���ԻO6e{�Mn�N%l���<f���+���/�a:�������K�g"��r�ͽq'u�d�%���^���֫������:\]�,_]ltv26�N��	k��Ğth�|[�zM��nq��Eg/&��՜���+����ȹL
���v�a��������$�޾l
�:
�o�l�e`�*1]�hOZ����N�+�i��}{K�4�N�a���b��Bb����Q�F�v24e<8�;���}.\�����v ���PH\i�2
*%j��N�(2�c�$�&:'��!t?)]��ED'�����]��t���� ����QP���*�dQ� �wӳZ�؀�l&���ˮ��y�PQP|b��]�6�ݺ�0N�C�(�P�+��v{��Dy����'�.�ew ���^Y�
{҃��ˋ��8h�a��gI|n�s����
���jSra����zl�<�4 r8Ec�{�N�N��!T��]�b�]�DAt���(�:� =�عF�DA�����+�
A7E��Ex((��\�킻����@tsu����۸;'�跿�����BBA�������V�j�@H(������hM���2r�CH(��H��6J�����a�e{{� :  �3wY�1=Lm 		�׃7֍�7}��l'�9�a����NSRO�E�Z�����[c{k/&=��b��{ccp�V������ܵ�0{UG�>�O((���o2� �rp�����0P��}�%�y�썹�Շ��&��-��z�u�1�.��Cg�j�QIV~��SY`�Q�	��{�Y�,���2��!��&�?��薦{xU(���uvK��	��%��O�l���B�_Z��샗���!��N\�z&�+y�cd3��[�{�ܜ��ڌ�K�P��"ۉ>X/����%��G�/�1|�y~I��S�'(�Mhof����7����B?A�Ż�n<r�I�<�B#a����Ł���S|��/JI�Ma����~�}p�G<ۼ-	�A����l8��w���,���o�a���9D���:f����Ƭ�ߧ�i��OB=A2ʶ�]��I���)�v��y��5��G&[��
$��+�����x�~k�I�W1��H	>�x�"�6mѷ �M�����E�����`��?�KN\�'(NƝKIQ���[.���&�*n?$Ғ&Z�8��Z��;A�7�X)���<'ǣ��֨�s�i=��3��[�:�x�"�	�+kTv{KP�8�6��ޒ���]��W;��!���Դ_ ��f�<'{%N�_Be����[_��H��l����8{PK�Yt9C�'_��������؊��B=A�Gv4�;	���44�!��+~�v���{lf�ls��	��� �ħ$����5��(>����"��U�P�#�9
�n#ŧ{���\��M�ʸpO�`�piC��2Fd/����u�0-��ĝY��`���W�a�(}O�Z%a�Gk�z��ѫ�g�>-�7��|K�6mM�E��V��w�Qh�l&�߰vw�C��1���8p�Q[j�ک�&�i��z'��s�g����.�ű�=1'�[�g�뮷�����s�{�-}��h
9]TT�pOP�9�o�.��,�����iN�I bW����B����W!��hK-��k��a�'��NP$9�M��f���y���/�����N�뗙"d��F�.�4B��+!�o����d{{N�k%�BZn�l$a�������$�I����*M�'�9����m�R���[\�l6�s��K����-.bN��S��R�[-V�U���&_�Q����;��nW+k3��	�D'mC���w|��ц��0OPd:q��`�fK{^aHB=As�]q>�v�_�*��/���zت�F~F9*\���̀C�'h��n��-����5��ع,�Hu7���'���]n W��H�'�9�HHQX�/SB=A񥝱�=�׷�tV��8�z��+ȵ�-!�ô���H,��B!��d�/J{{�@p�v,�k�9і���i�Ck�<A񡝶�`X�o�Δ��0O�
��M�1���7�����*O|L
�G�k�{��?�n\�J`���i撝�w�&p3,�|�I���!���k���o��2I���K��z����~�*�o�S�g�JS��ߟ�8�����      R   -  x�]ZI��[WޥX� �.���h����y��	�t��s��s_��s���s�{����>ሽ���.~����6c�����������ƿ�;G��g����71�߾�&ƿ��C��_\�'1���qq-��/�8Ʒk���m��$�7���?��xh���0�����X�wc|��wc|��}1�}q0�����z9��W_����t����{���e���5/�y0�G_߃�]�#�������;7F⡺?��k���_ �q���g��o���DƸyb�_�9�����ڂ�r7~#�}֒yj��-�\<�ˤ��,�6<n+tr&��?���쟖z��h�FB�����k�ܿ�>��n]���x�0e�݌y�q�f�9c�c�jlT��*�j�{� ��zL��=�v<��v[�6p��XǱxͬ�X̜u�S�q�<�\�3�c��>�õk1���-~��ֽ������B�O� �@,��L2g�*<Xt���UD�������h������Mz�=$'��ϋ"5�����Ѩ}�x4��a�xb?/�́�s��A;���bC;��_��0��p��\� ۛ�+��=l�)r�%.^����%&ɷ�ڸ�ES$�x�����$[����$��D�d�f�l�I������S�%������m[ɻ��9&y��xގg��Q4<���4�b��uL�N�z1-
�'G>������<�GŐ���7񮖘��+�Iޥ�cwL�F]<<��ù( ^�������1yg�Ԅ0�I^y�+K�3��*�}u"v��]���%���Z:;� {�#!�4�کc�r	�
�Ԅ$K�,К]��#_�(�%�t=:;���z瘀�Q��P��f�A,L�q�}�sj�t�lI{��[��#� Q]����
c�11�(�u&� w{K��D��^`Rq��N u|��D�-����a\`S�'"Щ�B>[>5��u�A�&���j֘�݁HT�a0�u���h/:�\X��P.��@�f1�	B5����PM���y��X>�jS-/��\>��j���] T�\"r�PM󪄀PM$��'�D3�G
�j>�PMT�� T�X2|�PM�T��j�`N�@��1�?�N8	��
�JզRX T�&�"�
w-	�j�| [��xL��\(��@��z�RB5���*��N,L%CE��f�ݼA���� �ປ,���|�D3��Ϥ�/���W4��Vw�V5CIm���ݼ���^Xv� ����5ۍ�ѝ�j�,� D��E�	V4C���\�f�5��\#�T��*�,4�j���@��l	D���Xk0�%xXl��� ������f(D4��N��շ1�@$���%{�%r�ks�@$��hV�mc�PM5C�3��f�'��{�� �f�|�P�jJ��'�k$���A���װ,?�j����݀�\.��Z����_�Hկv���D3�3B����	Bu�u�A�>5ݩ�f�kL�����ʑO����%���h�\�iOu���#�D�Θ@$����kE��'ջf�D T���c���vZ�j�b��C�фy���%��u4ank���#��f�B M��f(3B�����P]5C1�E3\���pF�N��|��}X�0����N�@�.���3�0���h¼�Xi"��(�P݇��	s�����j��q T��u T�p�	��f��	Bu�� T�� T��1D��ƁP=Z݌-�(�+gK �p�8��f8B����s2�E3ԙ�	��&�E3�(�	s���l/,[Q�}�4a��~h�|7Ė@����%�f�BΉo�㔺h���=�4a��ReK �R�{�#�0�Re�T3TE�����4a.���'M��f(J�J�ӄ�3NM��f��h��	D�j�ȿ�f�S��w�:�0�u�"��i�\5C�;F��1K�@$���LA����A z���	�w�	���:î���0Cm15�q�h���MX\Õӄ�մ7�AAT��P�{B�kpMX�f��$MX�f�CB�5�PcD�Nq���1�	��Ch�b5f�� �X�MЄ��N�T3�:A�!���MX�7�Z<5�#\�5T3����n��A�q7D�=�MX藸�B�����h�shA���aUw �:C�5D3��C��u�T3�٥	�|vi��&"j�7���6�5l��h���{ĉ�H5C}� ��j�3&�f8lB��� ��V� �:C�j���>�MXh���5bho�����i�B�GvjD�G�bho���V��� R�P'����݁H��%�f8���؛-�(۩�@��1DisI@��DZg�o;8'����C���@4�4a��rB�q[�h�:4a!��:c�j��x �o�Nܦ�u�B����m"+D��MX�w,�wMDϚ݁�i�� =��h�B���4a�
$MX�f8K�e��!pN�����P�&,D3�$�B�^��j�������8\�x"L�M	�Y_�H4��B�6Q�@��u�BB�^g���Zg��Bͫq����N� 8MX�o4a������h����`����!(�Q������@��&Θ@$���&,WS�l	D��#��ժ[�Ps����Ps�{BM��N�P�������BM��q Լ�K��m��T3Ա�f��� ��:C-	��w��	B�{T i�R5C����m�f��j��1�Ȇ?�	K�6qf"k\� �f8[BMk�-A�iM{�%Y�ul	D6�#���w���j��	BM_&5��<�dj�y�ЂP��K��^X�H4CI8���_�Lj�f(� ��V�c�T3T�@��u�z@������PS�u�A���C	 �Y������PS4��bj�f8��Zg8�� "�%Nh�R5C�8j�:'���$ R���Єe��h�2w4a����C����фe��	MX��Q�=����&,U3���p�r�M��)U�H5�L��m�ǆ&,w�Gl	D�j;h�R�Pؑ���3��@�]G�����@������|Fu�&,�f��XC>{�������˧q�����@$���6MX���%鷉:K���P��&,E3�I���Z��؛-���MX��8! �}��	�W�#���G�@�[5��EPUw�?T�	۪jv��K��y�@��j/,+D����@����@4�4a{5� 鷉�b�V�P�w�������_�U�����|>�Mk=�      P   E   x�3�tI�T��L+�4�40�20 "NC�ˈ3�(W��42��0���Lπ��3�K������� H��      D   (   x�3�t�-�ɯLM�2���L+Q�M�KLO-����� ��	K     
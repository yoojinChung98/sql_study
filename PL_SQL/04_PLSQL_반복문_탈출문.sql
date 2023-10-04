
-- WHILE ��

DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1; --begin
BEGIN
    WHILE v_count <=10 --end
    LOOP
        DBMS_OUTPUT.put_line(v_num);
        v_num := v_num + v_count;
        v_count := v_count +1; --step
    END LOOP;
    
    DBMS_OUTPUT.put_line(v_num);
END;

--Ż�⹮
DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1; --begin
BEGIN
    WHILE v_count <=10 --end
    LOOP
        EXIT WHEN v_count = 5;
        
        v_num := v_num + v_count;
        v_count := v_count +1; --step
    END LOOP;
    
    DBMS_OUTPUT.put_line(v_num);
END;


--FOR�� (FOR EACH ���� ����)
DECLARE
    v_num NUMBER := 4;
BEGIN
    
    FOR i IN 1..9 -- .. �� �ۼ��Ͽ� ���� ǥ��.
    LOOP   
        DBMS_OUTPUT.PUT_LINE(v_num || ' x ' || i || ' = ' || v_num*i );
    END LOOP;
    
END;

--CONTINUE��

DECLARE
    v_num NUMBER := 3;
BEGIN
    
    FOR i IN 1..9 -- .. �� �ۼ��Ͽ� ���� ǥ��.
    LOOP
        CONTINUE WHEN i=5;
        DBMS_OUTPUT.PUT_LINE(v_num || ' x ' || i || ' = ' || v_num*i );
    END LOOP;
    
END;





-- 1. ��� �������� ����ϴ� �͸� ����� ���弼��. (2 ~ 9��)
-- ¦���ܸ� ����� �ּ���. (2, 4, 6, 8)
-- ����� ����Ŭ ������ �߿��� �������� �˾Ƴ��� �����ڰ� �����. (% ����~)

DECLARE
BEGIN
    FOR v_dan IN 2..8
    LOOP
        CONTINUE WHEN CEIL(v_dan/2) <> v_dan/2;
        DBMS_OUTPUT.PUT_LINE('------' || v_dan || '��-----');
        
        FOR v_hang IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(v_dan || ' x ' || v_hang || ' = ' || v_dan*v_hang);
        END LOOP;
    END LOOP;
END;


BEGIN
    FOR dan IN 2..9
    LOOP
        IF MOD(dan,2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('������' || dan || '��');
            
            FOR hang IN 1..9
            LOOP
                DBMS_OUTPUT.PUT_LINE(dan || ' x ' || hang || ' = ' || dan*hang);
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('--------------------------');
        END IF;
    END LOOP;
END;


-- 2. INSERT�� 300�� �����ϴ� �͸� ����� ó���ϼ���.
-- board��� �̸��� ���̺��� ���弼��. (bno, writer, title �÷��� �����մϴ�.)
-- bno�� SEQUENCE�� �÷� �ֽð�, writer�� title�� ��ȣ�� �ٿ��� INSERT ������ �ּ���.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....

CREATE TABLE board (
    bno NUMBER PRIMARY KEY,
    writer VARCHAR2(15),
    title VARCHAR2(30)
);
        
CREATE SEQUENCE bno_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

DECLARE    
BEGIN
    FOR i IN 1..300
    LOOP
        INSERT INTO board
        VALUES(bno_seq.NEXTVAL, 'test'||i, 'title'||bno_seq.CURRVAL);
    END LOOP;
END;

SELECT * FROM board ORDER BY bno DESC;

DROP TABLE board;
DROP SEQUENCE bno_seq;




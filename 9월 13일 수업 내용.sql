DESC EMP;
DESC DEPT;
DESC BONUS;
DESC SALGRADE;
---------------------------------------------

 -- �⺻ SELECT *(���� �ǹ�) FROM EMP(���̺� �̸�);  �����ݷ����� ����
 SELECT * FROM EMP;
 -- EMP���̺��� �����ȣ, ����̸�, ����� ���� �μ���ȣ�� ��ȸ
 SELECT EMPNO, ENAME, DEPTNO
 FROM EMP;
 -- SQL�� �ۼ� �� ���� ����
 -- SQL���� ��ҹ��ڸ� �������� �ʴ´�.
 -- SQL������ ���� �Ǵ� ���� �ٿ� �Է� �� �� ����.
 -- �Ϲ������� Ű����� �빮�ڷ� �Է� �Ѵ�.
 -- SQL���� ������ ���� ;���� ������ �Ѵ�.
 
 -- �����ȣ�� �μ� ��ȣ�� �������� EMP ���̺� ��ȸ�ϱ�
 SELECT EMPNO, DEPTNO FROM EMP;
 -- ��Ī ���� �ϱ� : AS, �� �̸� �Ǵ� �÷� �̸��� ��Ī���� ǥ���� �� ����.
 SELECT ENAME AS �����, SAL AS ���޿�, SAL*12+COMM AS ����,COMM AS ������ 
 FROM EMP;
 
 
 ---�ߺ� �����ϱ�: DISTINCT, �����͸� ��ȸ�� �� �ߺ��� ������ �� �ϳ��� �����ϰ��� �ϴ� ���
 SELECT * FROM EMP;
 SELECT DISTINCT DEPTNO FROM EMP;
 SELECT DISTINCT JOB FROM EMP;
 -- �÷����� ����ϴ� ��������� : +,-,*,/
 SELECT ENAME, SAL, SAL-12
 FROM EMP;
 -- WHERE���� : �����͸� ��ȸ�� �� ����ڰ� ���ϴ� ���ǿ� �´� �����͸� ��ȸ�ϰ� ���� �� ���(���� ����)
 -- ���� �����ڿ� �԰� ��� ��.
 SELECT * FROM EMP
 WHERE DEPTNO = 10;    -- DB������ '=' ���ٶ�� �ǹ̷� ����.
 
 SELECT * FROM EMP
 WHERE EMPNO = 7369;
 
 --�޿��� 2500 �ʰ��� ����� �����ȣ, �̸�,����,�޿�
SELECT EMPNO AS �����ȣ,ENAME AS ����� ,JOB AS ����,SAL AS �޿�
FROM EMP
WHERE SAL > 2500;

SELECT *
FROM EMP
WHERE SAL * 12 = 36000;


-----�������� 500 �ʰ��� ��� ���
SELECT * FROM EMP
WHERE COMM > 500;

--�Ի����� 81�� 1�� 1�� ������ �����͸� ��ȸ�ϴ� ���
-- ��¥�� ���� ��� ��¥ ���Ŀ� ���缭 ���ϸ� ��.
SELECT * FROM EMP
WHERE HIREDATE < '81/01/01';

--���� ������ ǥ���ϴ� ����� �������� ����: <> , !=, ^=, NOT
SELECT * FROM EMP
WHERE DEPTNO ^= 30;

-- �޿��� 3000�̻��̰�, �μ��� 20���� ��� ��ȸ(2���� ������ ��� �����ؾ� �ϴ� ���)
SELECT * 
FROM EMP
WHERE SAL >= 3000 AND DEPTNO =20;

-- �޿��� 300�̻��̰�, �μ��� 20���̰�, �Ի����� 82�� 1��1�� ���� �Ի��� ��� ��ȸ
SELECT * 
FROM EMP
WHERE SAL >=3000 AND DEPTNO = 20 AND HIREDATE < '82/01/01';


--�޿��� 3000 �̻��̰�, �μ��� 20���̰ų� �Ի����� 82�� 1�� 1�� ������ ��� ��ȸ
SELECT *
FROM EMP
WHERE SAL >=3000  AND (DEPTNO = 20 OR HIREDATE <'82/01/01');


-- �޿��� 2500 �̻��̰� ������ MANAGER�� ��������� ���
SELECT * 
FROM EMP
WHERE SAL > 2500 AND JOB = 'MANAGER';


SELECT *
FROM EMP
WHERE SAL != 3000;


--IN������ : WHERE ���� ��, Ư�� ������ ������ ���.
SELECT *
FROM EMP
WHERE JOB IN ('MANAGER', 'SALESMAN','CLERK');   

SELECT *
FROM EMP
WHERE DEPTNO NOT IN (20,30);

--BETWEEN A AND B  ������ : ������ ������ ��ȸ�� �� ����ϴ� ������

--�޿��� 2000�̻� 3000������ ��� ��ȸ
SELECT * FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;




SELECT *
FROM EMP
WHERE EMPNO BETWEEN 7689 AND 9702;

-- 1980�⿡ �Ի����� ���� ��� ��ȸ
SELECT *
FROM EMP
WHERE NOT HIREDATE < '1981/01/01';

--LIKE, NOT LIKE ������: �Ϻ� ���ڿ��� ���ԵǾ� �ִ��� ���θ� Ȯ���ϴ� ������, �ַ� �˻����� ���
-- % : ���̿� ������� ��� ���ڸ� �ǹ�
-- _ : ���� 1�ڸ� �ǹ�
SELECT EMPNO, ENAME 
FROM EMP
WHERE ENAME LIKE '%K%';

SELECT *
FROM EMP
WHERE ENAME LIKE '_L%'
--��� �̸��� AM�� ���ԵǾ� �ִ� ��������� ���

SELECT *
FROM EMP
WHERE ENAME LIKE '%AM%';

-- ��� �̸��� AM�� ���ԵǾ� ���� ���� ��������� ���
SELECT *
FROM EMP
WHERE ENAME NOT LIKE '%AM%';

--NULL : ��Ȯ�� �Ǵ� �� �� ���� ���� �ǹ���, �׷��� ����, �Ҵ�, �� �Ұ�(=,IN���Ұ�)
SELECT ENAME, SAL*12+COMM AS ���� ,COMM
FROM EMP;

SELECT *
FROM EMP
WHERE COMM =NULL;  --���� ���⿡, ����Ұ�

--IS NULL
SELECT *
FROM EMP
WHERE COMM IS NOT NULL -- NULL ���θ� Ȯ���� �� ����ϴ� ������

--MANAGER�� �ִ� ����� ��ȸ.
SELECT *
FROM EMP
WHERE MGR IS NOT NULL;



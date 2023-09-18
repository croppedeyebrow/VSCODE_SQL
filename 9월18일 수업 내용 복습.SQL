-- GROUP BY절 : 여러 데이터에서 의미있는 하나의 결과를 특정 열 값 별로 묶어서 출력할 때 사용.
SELECT ROUND(AVG(SAL),2) AS 사원전체평균
FROM EMP;

--부서별 사원 평균.
SELECT ROUND(AVG(SAL),2) AS "부서별 평균"
FROM EMP
ORDER BY DEPTNO;


-- GROUP BY 절 없이 구현한다면?
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30;
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 20;
SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 10;


---집합 연산자를 사용하여, 구현하기
-- 각각의 SELECT 문은 특정 부서(DEPTNO)에 대한 평균 급여를 계산합니다. 
-- UNION ALL은 이러한 개별 결과를 하나의 결과 집합으로 결합

SELECT AVG(SAL) FROM EMP
WHERE DEPTNO = 10
UNION ALL

SELECT AVG(SAL) FROM EMP
WHERE DEPTNO = 20
UNION ALL

SELECT AVG(SAL) FROM EMP WHERE DEPTNO = 30;



-- 부서코드, 급여 합계, 부서 평균, 부서 코드 순 정렬을 
SELECT DEPTNO AS 부서코드,
     SUM(SAL) AS 급여합계,
      ROUND(AVG(SAL),2) 평균임금,
      COUNT(*) 인원수   -- 각 그룹에 해당하는 인원이 몇명인지 확인
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;      

---HAVING절..: GROUP BY 절이 존재하는 경우에만 사용 가능.
--GROUP BY 절을 통해 그룹화된 결과 값의 범위를 제한할 때 사용.
--WHERE절하고 기능이 비슷하지만, 따로 쓰는 이유는 실행 순서 때문.
-- WHERE 절은 주로 집계 함수와 함께 사용되지 않습니다. 
--집계 함수는 데이터를 그룹화하고 집계하는 데 사용됩니다.
-- HAVING 절은 집계 함수와 함께 사용되며,
-- 그룹화된 데이터를 필터링할 때 사용됩니다.

SELECT DEPTNO, JOB, ROUND(AVG(SAL),2)
FROM EMP
GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;   

SELECT DEPTNO, JOB, ROUND(AVG(SAL),2)
FROM EMP
WHERE SAL >= 2000
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
WHERE SAL <=3000
GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;      


--1.HAVING절을 사용하여 EMP 테이블의 부서별 직책의 평균 급여가 500 이상인 사원들의
-- 부서 번호, 직책, 부서별 직책의 평균 급여가 출력

SELECT DEPTNO, JOB, ROUND(AVG(SAL),2) AS 평균급여
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 500;

--2. EMP 테이블을 이용하여 부서번호, 평균급여, 최고급여, 최저급여, 사원수를 출력,  단, 평균 급여를 출력 할 때는 
--소수점 제외하고 부서 번호별로 출력.
SELECT DEPTNO, CAST(AVG(SAL)AS INT) AS "평균 급여",
 MAX(SAL) AS "최고 급여",
 MIN(SAL) AS "최저 급여",
 COUNT(*) AS 사원수
FROM EMP
GROUP BY DEPTNO; 

-- 3. 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원을 출력.
SELECT JOB AS 직책,
COUNT(*) AS "사원 수"
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >=3;

-- 4. 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력
-- SELECT EXTRACT(YEAR FROM HIREDATE) "입사일"
SELECT TO_CHAR(HIREDATE, 'YYYY')AS "입사 일",
DEPTNO,
COUNT(*) AS 사원수
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'YYYY'), DEPTNO
ORDER BY TO_CHAR(HIREDATE,'YYYY'); 

-- 5. 추가 수당을 받는 사원 수와 받지 않는 사원수를 출력.
SELECT NVL2(COMM,'O','X') AS "추가 수당",
COUNT(*)사원수
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');
-- NVL2는 Oracle 데이터베이스에서 사용되는 함수로, 
--특정 열 또는 표현식이 NULL인 경우와 그렇지 않은 경우에 
--서로 다른 값을 반환하는 데 사용.
--NVL2(expression, value_if_not_null, value_if_null)

-- 6. 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력.
SELECT DEPTNO,
TO_CHAR(HIREDATE, 'YYYY') AS "입사 년도",
COUNT(*) "사원 수",
MAX(SAL) "최고 급여",
SUM(SAL) "급여 합계",
TRUNC(AVG(SAL)) AS "평균 급여"
FROM EMP
GROUP BY DEPTNO, TO_CHAR(HIREDATE,'YYYY')
ORDER BY DEPTNO;

--------------------------그룹화와 관련된 여러 함수 :ROLLUP, CUBE..........
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

--ROLLUP: 명시한 열을 소그룹부터 대그룹의 순서로 각 그룹별 결과를 
-- 출력하고 마지막에 총 데이터 결과를 출력
-- 각 부서별 중간 결과를 보여 줌

--ROLLUP활용.
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);
-


-------------------------------------------------------------------
--조인: 2개 이상의 테이블에서 데이터를 가져와서 연결하는데 사용하는 SQL의 기능
-- JOIN은 SQL에서 하나 이상의 테이블 간에 데이터를 결합하고 관련 데이터를 추출하는 데 사용되는 중요한 연산
-- RDMS에서 테이블 설계시 무결성 원칙으로 인해 동일한 정보가 여러 군데 존재하면 
-- 안되기 때문에 필연적으로 테이블을 관리 목적에 맞게 설계 함.


SELECT * FROM EMP, DEPT;
--범위를 정해주지 않으면, 모든 열끼리 카테시안 곱 발생.


-- 열 이름을 비교하는 조건식으로 조인하기.

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMPNO;

---테이블 별칭 사용하기
SELECT *
FROM EMP E, DEPT D
     WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;

--조인 종류 : 두 개 이상의 테이블을 하나의 테이블처럼 가로로 늘려서 출력하기 위해 사용
-- 조인은 대상 데이터를 어떻게 연결하느냐에 따라 [등가/비등가/자체/외부] 조인으로 구분.
-- 등가 조인: 테이블을 연결한 후 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정하는 조인
-- 등가 조인에는 안시(ANSI) 조인과 오라클 조인이 있음.


--오라클 조인
SELECT EMPNO, ENAME, D.DEPTNO, DNAME, LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO=10
ORDER BY D.DEPTNO;

--안시 조인
SELECT EMPNO, ENAME, D.DEPTNO, DNAME, LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO = 10
ORDER BY D.DEPTNO;


--급여가 3000이상. WHERE절
SELECT EMPNO, ENAME, D.DEPTNO, DNAME,  LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND SAL >=3000
ORDER BY D.DEPTNO;

SELECT EMPNO, ENAME, D.DEPTNO, DNAME, LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE SAL >=3000
ORDER BY D.DEPTNO;

-- EMP 테이블 별칭을 E로, DEPT 테이블 별칭을 D로 하여 다음과 같이 등가 조인을 했을 때
-- 급여가 2500이하이고 사원 번호가 9999이하인 사원의 정보가 출력되도록 작성.

--ANSI 조인

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE SAL <= 2500
AND EMPNO <=9999
ORDER BY D.DEPTNO;

--오라클 조인.
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO -- 동등 조인, 이너 조인( 두 테이블이 일치하는 데이터만 선택)
AND SAL <= 2500
AND EMPNO <=9999
ORDER BY D.DEPTNO;




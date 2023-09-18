use sql_analyze;

# 승하차 구분 코드 별로 인원수가 많은 순으로 조회
SELECT * FROM TB_PBTRNSP;

SELECT A.STATN_NO, A.STATN_NM, A.HO_LN, A.TKCAR_GFF_SE_CD,
SUM(A.NMPR_CNT) AS NMPR_CNT
FROM TB_PBTRNSP A
WHERE A.STD_MT = '202304'
GROUP BY A.STATN_NO, A.STATN_NM, A.HO_LN, A.TKCAR_GFF_SE_CD
ORDER BY NMPR_CNT DESC;

# 승차 및 하차 인원수가 가장 적고, 가장 많은 역 조회 (승차의 1등,꼴등/ 하차의 1등,꼴등 구해야 = 총 4개역)
SELECT *
FROM (
        SELECT  A.STATN_NO, A.STATN_NM, A.HO_LN, A.TK_NMPR_CNT, A.GF_NMPR_CNT,
                ROW_NUMBER() over (ORDER BY A.TK_NMPR_CNT) AS RN_TK_NMPR_CNT_ASC,
                ROW_NUMBER() over (ORDER BY A.TK_NMPR_CNT DESC) AS RN_TK_NMPR_CNT_DESC,
                ROW_NUMBER() over (ORDER BY A.GF_NMPR_CNT) AS RN_GF_NMPR_CNT_ASC,
                ROW_NUMBER() over (ORDER BY A.GF_NMPR_CNT DESC) AS RN_GF_NMPR_CNT_DESC
        FROM(
                SELECT A.STATN_NO,
                       A.STATN_NM,
                       A.HO_LN,
                       MAX(A.TK_NMPR_CNT) AS TK_NMPR_CNT,
                       MAX(A.GF_NMPR_CNT) AS GF_NMPR_CNT
                FROM (
                        SELECT  A.STATN_NO,
                                A.STATN_NM,
                                A.HO_LN,
                                # 승하차 인원 컬럼 분리
                                CASE WHEN A.TKCAR_GFF_SE_CD ='TK' THEN A.NMPR_CNT ELSE 0 END AS TK_NMPR_CNT,
                                IF(A.TKCAR_GFF_SE_CD='GF', A.NMPR_CNT, 0) AS GF_NMPR_CNT

                        FROM (
                                SELECT  A.STATN_NO,
                                        A.STATN_NM,
                                        A.HO_LN,
                                        A.TKCAR_GFF_SE_CD,
                                        SUM(A.NMPR_CNT) AS NMPR_CNT

                                FROM TB_PBTRNSP A
                                WHERE A.STD_MT='202304'
                                GROUP BY A.STATN_NO, A.STATN_NM, A.HO_LN, A.TKCAR_GFF_SE_CD
                                ORDER BY NMPR_CNT DESC) as A
                     ) A
                GROUP BY A.STATN_NO, A.STATN_NM, A.HO_LN ) A ) B
WHERE B.RN_TK_NMPR_CNT_ASC = 1 OR B.RN_TK_NMPR_CNT_DESC = 1 OR B.RN_GF_NMPR_CNT_ASC = 1 OR B.RN_GF_NMPR_CNT_DESC = 1;

# 하차 인원수가 가장 많은 순으로 데이터 조회(출근 시간대)
SELECT A.STATN_NO, A.STATN_NM, A.HO_LN,
		SUM(A.NMPR_CNT) AS NMPR_CNT
FROM TB_PBTRNSP A
WHERE A.STD_MT = '202304'
 AND A.BEGIN_TIME = '1800' AND A.END_TIME = '1900'
 AND A.TKCAR_GFF_SE_CD = 'TK' -- get off(하차)
GROUP BY A.STATN_NO, A.STATN_NM, A.HO_LN
ORDER BY NMPR_CNT DESC
LIMIT 10
;

# 23시 이후 어디서 많이 승차하는지 확인 (막차 시간) 
-- 지하철이 끊길 가능서잉 높으니 택시를 많이 이용하는 역은..?
SELECT A.STATN_NO, A.STATN_NM, A.HO_LN,
		SUM(A.NMPR_CNT) AS NMPR_CNT
FROM TB_PBTRNSP A
WHERE A.STD_MT = '202304'
 AND (A.BEGIN_TIME, A.END_TIME) IN (('2300','2400'),
									('0000','0100'),
                                    ('0100','0200'),
                                    ('0200','0300'),
                                    ('0300','0400'))
 AND A.TKCAR_GFF_SE_CD = 'TK' -- get off(하차)
GROUP BY A.STATN_NO, A.STATN_NM, A.HO_LN
ORDER BY NMPR_CNT DESC
LIMIT 10
;


# 각 호선 별 승하차 인원수가 가장 많은 역 구하기

SELECT *
FROM (
		SELECT A.STATN_NO, A.HO_LN, A.STATN_NM,
				A.sum,
				ROW_NUMBER() OVER (PARTITION BY HO_LN ORDER BY A.sum DESC) as RNUM
		FROM (SELECT STATN_NO, HO_LN,STATN_NM, SUM(NMPR_CNT) as sum
				FROM TB_PBTRNSP A
				WHERE A.STD_MT = '202304'
				GROUP BY STATN_NO, HO_LN, STATN_NM) A) A
WHERE A.RNUM = 1
ORDER BY A.sum DESC;
		
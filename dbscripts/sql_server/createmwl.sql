	create table mwl (
		stuinsuid	char(64),
		refstusopcla	char(64),
		refstusopins	char(64),
		reqproid	char(30),
		plaordnum	char(22),
		filordnum	char(22),
		accnum		char(20),
		quatim		char(20),
		everea		char(20) NULL,
		reqdattim	char(20) NULL,
		spesou		char(20) NULL,
		ordpro		char(20) NULL,
		reqprodes	char(64),
		reqprocod	char(30) NULL,
		occnum		char(20) NULL,
		apptimqua	char(30) NULL,
		orduid		char(64),
		spsid		char(16),
		spsindex	char(16),
		schaet		char(16),
		spsstadat	char(8),
		spsstatim	char(16),
		mod		char(16),
		schperphynam	char(64) NULL,
		spsdes		char(64),
		spsloc		char(16) NULL,
		premed		char(64) NULL,
		reqconage	char(64) NULL,
		schstanam	char(16),
		spssta		char(16) NULL,
		reqphynam	char(64) NULL,
		refphynam	char(64),
		patid		char(20),
		issuer		char(20),
		patid2		char(20),
		issuer2		char(20),
		nam		char(64),
		datbir		char(8),
		sex		char(4),
		pataccnum	char(20) NULL,
		patrac		char(20) NULL,
		codmea		char(64),
		codval 		char(20),
		codschdes       char(20),
		pregstat	char(4) NULL,
		curpatloc	char(64) NULL,
		admid		char(64),
		issueradmid	char(64) NULL
	)
	go


<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:tei="http://www.tei-c.org/ns/1.0"
                              xmlns="http://www.w3.org/1999/xhtml">

	<xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
	
	<xsl:template match="/">
		<html>
			<head>
				<meta charset="UTF-8"/>
				<meta name="viewport" content="initial-scale=1.0, width=device-width" />
				<link rel="stylesheet" type="text/css" href="style.css" media="screen" />  
	     		<script src="funzioni.js"> </script>
		        <title>
		        	<xsl:value-of select="//tei:title"/>
		        </title>
			</head>
			<body>
				<xsl:apply-templates select="//tei:teiHeader"/>
				<div id="contenitore">
					<div id="parte_immagine">
						<xsl:apply-templates select="//tei:graphic"/>
					</div>
					<div id="parte_testo">
						<xsl:apply-templates select="//tei:front"/>
						<xsl:apply-templates select="//tei:div[@type='opener']"/>
						<xsl:apply-templates select="//tei:div[@type='opener']/tei:salute"/>
						<xsl:apply-templates select="//tei:div[@type='letter-body']"/>
						<xsl:apply-templates select="//tei:div[@type='closer']"/>
						<xsl:apply-templates select="//tei:div[@type='paratext']"/>
					</div>
				</div>
				<div id="footer">
					<xsl:apply-templates select="//tei:div[@type='notes']"/>
					<xsl:apply-templates select="//tei:div[@type='bibliography']"/>
				</div>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="//tei:graphic[@url = 'LL1.34.I.jpg']">
		<xsl:element name="div">
			<xsl:attribute name="id">
		          <xsl:text>sticky</xsl:text>
		    </xsl:attribute> 
			<xsl:element name="div">
				<xsl:attribute name="id">
		          <xsl:text>rotazione</xsl:text>
				</xsl:attribute> 
				<xsl:attribute name="class">
					<xsl:text>img-magnifier-container</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="style">
					  <xsl:text>transform:rotate(0deg)</xsl:text>
				</xsl:attribute> 
		    <xsl:element name="img">    
		    <xsl:attribute name="usemap">
		          <xsl:value-of select="concat('#','mappa')"/>
		    </xsl:attribute>
		    <xsl:attribute name="id">
		          <xsl:text>lettera_con_zone</xsl:text>
		    </xsl:attribute> 
		    <xsl:attribute name="src">
		          <xsl:value-of select="current()/@url"/>
		    </xsl:attribute>
		    <xsl:attribute name="style">
		          <xsl:text>max-width: 100%</xsl:text>
		    </xsl:attribute>
		    	<xsl:element name="map">
		         	<xsl:attribute name="id">
		            	<xsl:text>mappa</xsl:text>
		          	</xsl:attribute>
		         		<xsl:apply-templates select="//tei:zone"/>
			   		</xsl:element>
			</xsl:element>
		</xsl:element>
		<xsl:element name="input">
			<xsl:attribute name="type">
				<xsl:text>button</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="value">
				<xsl:text>Ruota</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="onclick">
				<xsl:text>ruota()</xsl:text>
			</xsl:attribute>
		</xsl:element>
		<xsl:element name="input">
			<xsl:attribute name="type">
				<xsl:text>button</xsl:text></xsl:attribute>
			<xsl:attribute name="value">
				<xsl:text>Zoom</xsl:text></xsl:attribute>
			<xsl:attribute name="onclick">
				<xsl:text>magnify('lettera_con_zone',3)</xsl:text>
			</xsl:attribute>
			</xsl:element>
			<xsl:element name="input">
				<xsl:attribute name="type">
					<xsl:text>button</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="value">
					<xsl:text>Disattiva zoom</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="onclick">
					<xsl:text>disattiva()</xsl:text>
				</xsl:attribute>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="//tei:zone">
				<xsl:element name="area">
					<xsl:attribute name="id">
						<xsl:value-of select="@xml:id"/>
					</xsl:attribute>
					<xsl:attribute name="shape">
						<xsl:text>rect</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="coords">
						<xsl:value-of select="@ulx"/>,<xsl:value-of select="@uly"/>,<xsl:value-of select="@lrx"/>,<xsl:value-of select="@lry"/>
					</xsl:attribute>
				</xsl:element>
	</xsl:template>
	
	<xsl:template match="//tei:teiHeader">
	<xsl:element name="div">
			<xsl:attribute name="id">
	<xsl:text>superiore</xsl:text></xsl:attribute>
	<xsl:element name="h1">
			<xsl:attribute name="id">
					<xsl:text>titolo</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="align">
				<xsl:text>center</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="current()//tei:title"/>
	</xsl:element>
	<xsl:element name="h2">
			<xsl:attribute name="id">
					<xsl:text>sottotitolo</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="align">
				<xsl:text>center</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="current()//tei:edition/text()"/>- <xsl:value-of select="current()//tei:date"/>
	</xsl:element>
	<xsl:element name="div">
	<xsl:attribute name="id">
					<xsl:text>informazioni</xsl:text>
			</xsl:attribute>
		<xsl:attribute name="align">left</xsl:attribute>
			<b>Trascrizione:</b> <xsl:value-of select="//tei:name[@ref]"/><br/>
			<b>Editore:</b> <xsl:value-of select="//tei:publisher"/><br/>
			<h3><u class="mostra" onclick="mostraNascondi('info1')">Informazioni sul supporto</u></h3>
			<p id="info1">
			<xsl:attribute name="style">display:none</xsl:attribute>
			Ubicazione: <xsl:value-of select="//tei:msIdentifier/tei:country"/>, <xsl:value-of select="//tei:msIdentifier/tei:settlement"/>, <xsl:value-of select="//tei:msIdentifier/tei:repository"/>, <xsl:value-of select="//tei:msIdentifier/tei:idno"/><br/>
			Collocazione: <xsl:value-of select="//tei:altIdentifier/tei:idno"/><xsl:if test="//tei:altIdentifier//tei:note">. (<xsl:value-of select=".//tei:note"/>)</xsl:if><br/>
			Formato: <xsl:choose><xsl:when test="//tei:dimensions[@unit = 'cm']">cm </xsl:when><xsl:otherwise>mm </xsl:otherwise></xsl:choose><xsl:value-of select="//tei:height"/>x<xsl:value-of select="//tei:width"/><br/>
			Materiale: <xsl:value-of select="//tei:material"/><br/>
			Stato: <xsl:value-of select="//tei:condition"/><br/>
			</p>
			<h3><u class="mostra" onclick="mostraNascondi('info2')">Informazioni sulla lettera</u></h3>
			<p id="info2">
			<xsl:attribute name="style">display:none</xsl:attribute>
			Lingua: <xsl:value-of select="//tei:langUsage"/><br/>
			Mani: <xsl:value-of select="//tei:handDesc/@hands"/> (<xsl:for-each select="//tei:handNote"><xsl:value-of select="@xml:id"/> - <xsl:value-of select="."/> </xsl:for-each>)<br/>
			Note: <xsl:for-each select="//tei:teiHeader//tei:note"><xsl:value-of select="."/> </xsl:for-each><br/>
			</p>
			<h3><u class="mostra" onclick="mostraNascondi('info3')">Codifica</u></h3>
			<xsl:element name="p">
			<xsl:attribute name="id">info3</xsl:attribute>
			<xsl:attribute name="style">display:none</xsl:attribute>
			Responsabili: <xsl:for-each select="//tei:editionStmt//tei:name"><xsl:value-of select=".//tei:forename"/><xsl:text>&#160;</xsl:text><xsl:value-of select=".//tei:surname"/>. </xsl:for-each><br/>
			Progetto: <xsl:value-of select="//tei:projectDesc"/><br/>
			Normalizzazioni: <xsl:value-of select="//tei:normalization"/><br/>
			</xsl:element>
					Revisioni:
			<xsl:element name="ul">
			<xsl:for-each select="//tei:change"><li>
			<xsl:value-of select="@when"/>: <xsl:value-of select="."/></li></xsl:for-each><br/>
			</xsl:element>
	</xsl:element>
	</xsl:element>
	</xsl:template>

	<xsl:template match="//tei:front">
		<xsl:text>Nel recto si trova "</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>". Nel verso: </xsl:text>
	</xsl:template>
	
	<xsl:template match="//tei:div[@type='opener']">
		<p align="right">
			<xsl:value-of select="//tei:dateline"/>
		</p>
	</xsl:template>

	<xsl:template match="tei:div[@type='letter-body']">
			<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="//tei:div[@type='closer']">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="//tei:div[@type='paratext']">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="tei:s">
		<xsl:element name="p">
			<xsl:attribute name="id">
				<xsl:value-of select="@n"/>
			</xsl:attribute>
			<xsl:if test="@rend = 'align(center)'">
				<xsl:attribute name="align">
					<xsl:text>left</xsl:text>
				</xsl:attribute>
				<xsl:text>&#9;&#9;&#9;</xsl:text>
			</xsl:if>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="//tei:lb">
		<xsl:element name="br"/>
			<xsl:element name="span">
				<xsl:attribute name="id">
					<xsl:value-of select="@facs"/>
				</xsl:attribute>
				<xsl:attribute name="n">
					<xsl:value-of select="@n"/>
				</xsl:attribute>
				<xsl:attribute name="class">
					<xsl:text>hotspot</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="concat(current()/@n, ' ')"/>-
			</xsl:element>
	</xsl:template>
	
<!--	
	<xsl:template match="tei:persName | tei:orgName | tei:placeName | tei:term | tei:rs | tei:ref">
		<xsl:element name="span">
			<xsl:attribute name="style">
				<xsl:text>background-color:green</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
-->

	<xsl:template match="tei:choice | tei:subst">
		<xsl:choose>
			<xsl:when test=".//tei:lb and .//tei:gap">
				<xsl:apply-templates/>[<i>lectio</i> ammodernata]
			</xsl:when>
			<xsl:when test=".//tei:lb">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test=".//tei:orig and .//tei:reg and .//tei:choice">
				<abbr><xsl:attribute name="title"><xsl:value-of select=".//tei:reg"/></xsl:attribute><xsl:value-of select=".//tei:abbr"/> Marchesa</abbr>
			</xsl:when>
			<xsl:when test=".//tei:orig and .//tei:reg">
				<abbr><xsl:attribute name="title"><xsl:value-of select=".//tei:reg"/></xsl:attribute><xsl:value-of select=".//tei:orig"/></abbr>
			</xsl:when>
			<xsl:when test=".//tei:sic and .//tei:corr">
				<abbr><xsl:attribute name="title"><xsl:value-of select=".//tei:corr"/></xsl:attribute><xsl:value-of select=".//tei:sic"/></abbr>
			</xsl:when>
			<xsl:when test=".//tei:del and .//tei:add and .//tei:add/tei:del">
				<abbr><xsl:attribute name="title"><xsl:value-of select=".//tei:del"/></xsl:attribute><xsl:value-of select=".//tei:add"/></abbr><xsl:apply-templates></xsl:apply-templates>
			</xsl:when>
			<xsl:when test=".//tei:del and .//tei:add">
				<abbr><xsl:attribute name="title"><xsl:value-of select=".//tei:del"/></xsl:attribute><xsl:value-of select=".//tei:add"/></abbr>
			</xsl:when>
			<xsl:when test=".//tei:abbr and .//tei:expan">
				<abbr><xsl:attribute name="title"><xsl:value-of select=".//tei:expan"/></xsl:attribute><xsl:value-of select=".//tei:abbr"/></abbr>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="//tei:hi[@rendition='#italic']">
		<span>
		<xsl:attribute name="style">
			<xsl:value-of select="//tei:rendition[@xml:id = substring(current()/@rendition,2)]"/>
		</xsl:attribute>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="//tei:ab">
		<xsl:choose>
			<xsl:when test="current()/@n = 'ab_02'">
				<xsl:apply-templates/> (seconda mano)
			</xsl:when>
			<xsl:when test="current()/@n = 'ab_03'">
				<xsl:apply-templates/> (terza mano)
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="//tei:del">
		<s>
			<xsl:apply-templates/>
		</s>
	</xsl:template>

	<xsl:template match="//tei:ptr">
		<xsl:element name="a">
			<xsl:attribute name="href">	
				<xsl:value-of select="concat('#',substring(@target,15))"/>
			</xsl:attribute>
			[<xsl:value-of select="substring(@target,15)"/>]
		</xsl:element>
	</xsl:template>

	<xsl:template match="//tei:w">
		[<xsl:apply-templates/>]
	</xsl:template>

	<xsl:template match="//tei:div[@type='notes']">
		<xsl:element name="div">
			<xsl:attribute name="id">
				<xsl:text>inferiore</xsl:text>
			</xsl:attribute>
			<xsl:element name="h3">
				<xsl:text>Note</xsl:text>
			</xsl:element>
			<xsl:for-each select=".//tei:note">
				<xsl:element name="p">
					<xsl:attribute name="id">
						<xsl:value-of select="substring(@xml:id,14)"/>
					</xsl:attribute>
					[<xsl:value-of select="substring(@xml:id,14)"/>]. <xsl:value-of select="./tei:p"/>
					<xsl:for-each select="current()/tei:bibl">
						<xsl:element name="p">
							<xsl:text>--- Fonte: </xsl:text>
							<xsl:if test="parent::tei:note[@source='TEI-ListBibl.xml#Seminara2017']">
								<xsl:text>Seminara 2017, </xsl:text>
							</xsl:if>
							<xsl:value-of select="text()"/>p.<xsl:value-of select="current()/tei:citedRange"/>
							<xsl:if test="parent::tei:note[@ana = '972']">
								<xsl:text> n. 972</xsl:text>
							</xsl:if>
							<xsl:if test="parent::tei:note[@ana = '973']">
								<xsl:text> n. 973</xsl:text>
							</xsl:if>
						</xsl:element>
					</xsl:for-each>	
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>

	<xsl:template match="//tei:div[@type='bibliography']">
		<xsl:element name="div">	
			<xsl:attribute name="id">
						<xsl:text>bibliografia</xsl:text>
			</xsl:attribute>
			<xsl:element name="h3">
				<xsl:attribute name="id">
					<xsl:text>titolo_bibl</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="current()//tei:head"/>
			</xsl:element>
				<xsl:element name="p">
					<xsl:attribute name="id">
						<xsl:text>inferiore</xsl:text>
					</xsl:attribute>
						<xsl:element name="ul">
							<xsl:for-each select="current()//tei:bibl">
								<xsl:element name="li">
								<xsl:value-of select="current()//tei:author"/>&#160;<xsl:value-of select="current()//tei:date"/>, p. <xsl:value-of select="current()//tei:citedRange"/>
							</xsl:element>
							</xsl:for-each>
						</xsl:element>
				</xsl:element>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>

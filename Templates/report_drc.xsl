<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version = '2.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
<xsl:param name="file_extension">drc</xsl:param>
	
<xsl:output method="text" version="1.0" encoding="iso-8859-1"/>

<xsl:template match="report">
	<xsl:apply-templates select="title"/>
	<xsl:apply-templates select="filename"/>
	<xsl:apply-templates select="date"/>
	<xsl:apply-templates select="time"/>
	<xsl:apply-templates select="error"/>
	<xsl:call-template name="new_line"/>
	<xsl:apply-templates select="//table"/>
	<xsl:call-template name="new_line"/>
	<xsl:call-template name="total_violation_count"/>
	<xsl:apply-templates select="elapsed_time"/>
</xsl:template>

<xsl:template name="new_line">
<xsl:text>&#10;</xsl:text>	
</xsl:template>

<xsl:template name="total_violation_count">
Violations Detected : <xsl:value-of select="count(table[type='rule']//row)"/>
</xsl:template>

<xsl:template name="space">
	<xsl:param name="n" select="1"/>
	<xsl:text>&#32;</xsl:text>
	<xsl:if test="$n != 1">
		<xsl:call-template name="space">
			<xsl:with-param name="n" select="$n - 1"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="leading_space">
<xsl:text>&#32;&#32;&#32;&#32;</xsl:text>	
</xsl:template>

<xsl:template match="table">
<xsl:call-template name="new_line"/>
<xsl:if test="not(@suppress_title)"><xsl:apply-templates select="title"/></xsl:if>
<xsl:if test="type='warning'">WARNING: </xsl:if>
<xsl:if test="type='rule'">Processing Rule : </xsl:if>
<xsl:apply-templates select="columns"/>
<xsl:call-template name="new_line"/>
<xsl:apply-templates select="row"/>
<xsl:if test="not(type='warning')">Rule Violations :<xsl:value-of select="count(row)"/><xsl:call-template name="new_line"/></xsl:if>
</xsl:template>

<xsl:template match="columns">
	<xsl:variable name="html_class"><xsl:value-of select="parent::*/table/@html_class"/></xsl:variable>
	<xsl:choose>
		<xsl:when test="@use='title'">
			<xsl:if test="not($html_class='')"><xsl:value-of select="$html_class"/>: </xsl:if><xsl:apply-templates select="parent::*/title"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="column">
					<xsl:if test="position()=1" >
						<xsl:if test="not($html_class='')"><xsl:value-of select="$html_class"/>:</xsl:if>
					</xsl:if>
					<xsl:apply-templates select="."/>
					<xsl:if test="not(count(parent::*/column) = position())">, </xsl:if>	
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="row">
	<xsl:call-template name="space"><xsl:with-param name="n" select="3"/></xsl:call-template>
	<xsl:if test="parent::*/type='rule'">Violation between </xsl:if>	
	<xsl:for-each select="cell">
		<xsl:if test="not(position() = 1)"><xsl:call-template name="new_line"/><xsl:call-template name="space"><xsl:with-param name="n" select="21"/></xsl:call-template></xsl:if>
		<xsl:apply-templates select="."/><xsl:if test="not(count(parent::*/cell) = position())"> and </xsl:if>		
	</xsl:for-each>	
	<xsl:call-template name="new_line"/>
</xsl:template>

<xsl:template match="coordinate">
	<xsl:choose>
		<xsl:when test="//units/@default = 'mm'"><xsl:value-of select="format-number(0.0254 * text() div 10000, '0.####')"/>mm</xsl:when>
		<xsl:otherwise><xsl:value-of select="format-number(text() div 10000, '0.###')"/>mils</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="report/filename">
PCB File : <xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="date">
Date     : <xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="report/title">Protel Design System Design Rule Check</xsl:template>

<xsl:template match="time">
Time     : <xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="elapsed_time">
Time Elapsed        : <xsl:value-of select="text()"/>
</xsl:template>

<xsl:template match="error">
<xsl:call-template name="new_line"/>
ERROR : <xsl:value-of select="."/>
</xsl:template>

</xsl:stylesheet>

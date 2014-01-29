<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version = '2.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
<xsl:param name="file_extension">txt</xsl:param>
    
<xsl:output method="text" version="1.0" encoding="iso-8859-1"/>

<xsl:template match="report">
    <xsl:call-template name="total_warning_count"/>
    <xsl:call-template name="total_violation_count"/>
    <xsl:apply-templates select="//section//table"/>
    <xsl:call-template name="warning_total"/>
    <xsl:apply-templates select="//table[type='rule']"/>
    <xsl:call-template name="violation_total"/>
    <xsl:apply-templates select="//row"/>
</xsl:template>

<xsl:template name="new_line">
<xsl:text>&#10;</xsl:text>  
</xsl:template>

<xsl:template match="table">
<xsl:if test="not(@suppress_title)"><xsl:apply-templates select="title"/></xsl:if>
<xsl:if test="type='warning'">Warnings|</xsl:if>
<xsl:if test="type='rule'">Rule Violations|</xsl:if>
<xsl:apply-templates select="columns"/>
<xsl:if test="type='rule'">|<xsl:value-of select="count(row)"/></xsl:if>
<xsl:if test="type='warning'">|<xsl:value-of select="count(row)"/></xsl:if>
<xsl:call-template name="new_line"/>
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
    <xsl:if test="parent::*/type='rule'">
        <xsl:value-of select="parent::*/title"/>
        <xsl:choose>
            <xsl:when test="count(cell) = 1">|||</xsl:when>
            <xsl:when test="count(cell) = 2">||||</xsl:when>
        </xsl:choose>
    </xsl:if>    
    <xsl:if test="parent::*/type='warning'"><xsl:value-of select="parent::*/title"/>|||</xsl:if>    
    <xsl:for-each select="cell">
        <xsl:apply-templates select="."/><xsl:if test="not(count(parent::*/cell) = position())">|</xsl:if>      
    </xsl:for-each> 
    <xsl:call-template name="new_line"/>
</xsl:template>

<xsl:template match="coordinate">
    <xsl:choose>
        <xsl:when test="//units/@default = 'mm'"><xsl:value-of select="format-number(0.0254 * text() div 10000, '0.####')"/>mm</xsl:when>
        <xsl:otherwise><xsl:value-of select="format-number(text() div 10000, '0.###')"/>mils</xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="total_warning_count">
Warnings|Total|<xsl:value-of select="count(section//table//row)"/>
</xsl:template>

<xsl:template name="total_violation_count">
Violations|Total|<xsl:value-of select="count(table[type='rule']//row)"/>
<xsl:call-template name="new_line"/>
</xsl:template>

<xsl:template name="warning_total">
Warnings|Total|<xsl:value-of select="count(section//table//row)"/>
<xsl:call-template name="new_line"/>
</xsl:template>

<xsl:template name="violation_total">
Rule Violations|Total|<xsl:value-of select="count(table[type='rule']//row)"/>
<xsl:call-template name="new_line"/>
</xsl:template>

</xsl:stylesheet>

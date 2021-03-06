<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:srv="http://www.isotc211.org/2005/srv"
                xmlns:gmx="http://www.isotc211.org/2005/gmx"
                xmlns:gn="http://www.fao.org/geonetwork"
                version="2.0"
                exclude-result-prefixes="#all">

  <xsl:include href="utility-tpl-multilingual.xsl"/>

 <xsl:template name="get-iso19139.nonspatial-title">
    <xsl:call-template name="get-iso19139-title"/>
  </xsl:template>

  <xsl:template name="get-iso19139.nonspatial-is-service">
    <xsl:call-template name="get-iso19139-is-service"/>
  </xsl:template>

  <xsl:template name="get-iso19139.nonspatial-extents-as-json">
    <xsl:call-template name="get-iso19139-extents-as-json"/>
  </xsl:template>

  <xsl:template name="get-iso19139.nonspatial-online-source-config">
    <xsl:param name="pattern"/>
    <xsl:call-template name="get-iso19139-online-source-config">
        <xsl:with-param name="pattern" select="$pattern"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
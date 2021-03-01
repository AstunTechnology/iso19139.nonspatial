<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gts="http://www.isotc211.org/2005/gts"
                xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gmx="http://www.isotc211.org/2005/gmx"
                xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:gml="http://www.opengis.net/gml/3.2"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:gn="http://www.fao.org/geonetwork"
                xmlns:gn-fn-core="http://geonetwork-opensource.org/xsl/functions/core"
                xmlns:gn-fn-metadata="http://geonetwork-opensource.org/xsl/functions/metadata"
                xmlns:gn-fn-iso19139="http://geonetwork-opensource.org/xsl/functions/profiles/iso19139"
                xmlns:exslt="http://exslt.org/common" exclude-result-prefixes="#all">

  <!-- Readonly elements -->
 <xsl:template mode="mode-iso19139" priority="5000" match="gmd:metadataStandardName[$schema='iso19139.nonspatial']|gmd:metadataStandardVersion[$schema='iso19139.nonspatial']">
    <xsl:param name="schema" select="$schema" required="no"/>
    <xsl:param name="labels" select="$labels" required="no"/>
    <xsl:param name="overrideLabel" select="''" required="no"/>

    <xsl:variable name="xpath" select="gn-fn-metadata:getXPath(.)"/>
    <xsl:variable name="isoType" select="if (../@gco:isoType) then ../@gco:isoType else ''"/>
    <xsl:variable name="fieldLabelConfig"
                  select="gn-fn-metadata:getLabel($schema, name(), $labels, name(..), $isoType, $xpath)"/>

    <xsl:variable name="labelConfig">
      <xsl:choose>
        <xsl:when test="$overrideLabel != ''">
          <element>
            <label><xsl:value-of select="$overrideLabel"/></label>
          </element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="$fieldLabelConfig"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <xsl:variable name="xpath" select="gn-fn-metadata:getXPath(.)" />

    <xsl:call-template name="render-element">
      <xsl:with-param name="label"
                      select="$labelConfig/*"/>
      <xsl:with-param name="value" select="*"/>
      <xsl:with-param name="cls" select="local-name()"/>
      <xsl:with-param name="xpath" select="$xpath"/>
      <xsl:with-param name="type" select="gn-fn-metadata:getFieldType($editorConfig, name(), '', $xpath)"/>
      <xsl:with-param name="name" select="''"/>
      <xsl:with-param name="editInfo" select="*/gn:element"/>
      <xsl:with-param name="parentEditInfo" select="gn:element"/>
      <xsl:with-param name="isDisabled" select="true()"/>
    </xsl:call-template>

  </xsl:template>
</xsl:stylesheet>

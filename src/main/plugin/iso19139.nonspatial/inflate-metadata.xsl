<?xml version="1.0" encoding="UTF-8"?>

<!--
  ~ Copyright (C) 2001-2016 Food and Agriculture Organization of the
  ~ United Nations (FAO-UN), United Nations World Food Programme (WFP)
  ~ and United Nations Environment Programme (UNEP)
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or (at
  ~ your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful, but
  ~ WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  ~ General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  ~
  ~ Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
  ~ Rome - Italy. email: geonetwork@osgeo.org
  -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gml="http://www.opengis.net/gml/3.2"
                xmlns:srv="http://www.isotc211.org/2005/srv"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                version="2.0">


  <xsl:template match="/root">
    <xsl:apply-templates select="gmd:*"/>
  </xsl:template>

  <!-- datasets -->

  <xsl:template match="gmd:MD_DataIdentification">
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:copy-of select="gmd:citation" />
      <xsl:copy-of select="gmd:abstract" />
      <xsl:copy-of select="gmd:purpose" />
      <xsl:copy-of select="gmd:credit" />
      <xsl:copy-of select="gmd:status" />
      <xsl:copy-of select="gmd:pointOfContact" />
      <xsl:copy-of select="gmd:resourceMaintenance" />
      <xsl:copy-of select="gmd:graphicOverview" />
      <xsl:copy-of select="gmd:resourceFormat" />
      <xsl:copy-of select="gmd:descriptiveKeywords" />
      <xsl:copy-of select="gmd:resourceSpecificUsage" />
      <xsl:copy-of select="gmd:resourceConstraints" />
      <xsl:copy-of select="gmd:aggregationInfo" />
      <xsl:copy-of select="gmd:language" />
      <xsl:copy-of select="gmd:characterSet" />
      <!-- Add characterSet if missing -->
      <xsl:if test="not(gmd:characterSet)">
        <gmd:characterSet>
          <gmd:MD_CharacterSetCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/gmxCodelists.xml#MD_CharacterSetCode"
                                     codeListValue="utf8">UTF-8</gmd:MD_CharacterSetCode>
        </gmd:characterSet>
      </xsl:if>
      <xsl:copy-of select="gmd:topicCategory" />
      <!-- Add gmd:topicCategory if missing -->
      <xsl:if test="not(gmd:topicCategory)">
        <gmd:topicCategory>
          <gmd:MD_TopicCategoryCode></gmd:MD_TopicCategoryCode>
        </gmd:topicCategory>
      </xsl:if>
      <xsl:copy-of select="gmd:environmentDescription" />
      <xsl:copy-of select="gmd:extent" />
      <!-- add temporal extent if missing -->
      <!-- <xsl:if test="not(gmd:extent)">
          <xsl:message>No extent element</xsl:message>
          <gmd:extent>
            <gmd:EX_Extent>
              <xsl:call-template name="addTimePeriodElement" />
            </gmd:EX_Extent>
          </gmd:extent>
        </xsl:if> -->
      <xsl:copy-of select="gmd:supplementalInformation" />
    </xsl:copy>
  </xsl:template>

 <!--  <xsl:template match="gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent">
    <xsl:message>Matching temporal extent template</xsl:message>
    <xsl:message><xsl:value-of select="count(gml:TimePeriod)"/></xsl:message>
    <xsl:if test="count(gml:TimePeriod)=0">
        <xsl:message>No temporal extent</xsl:message>
             <xsl:call-template name="addTimePeriodElement" />
        </xsl:if>
  </xsl:template> -->

  <xsl:template match="gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine/gmd:CI_OnlineResource">      
    
    <!-- tests for missing various transferOptions elements -->
     <xsl:variable name="hasOnlineResourceName" select="count(gmd:name) > 0" />
      <xsl:variable name="hasOnlineResourceDescription" select="count(gmd:description) > 0" />
      <xsl:variable name="hasOnlineResourceLinkage" select="count(gmd:linkage) > 0" />
      <xsl:variable name="hasOnlineResourceProtocol" select="count(gmd:protocol) > 0" />
    
    <xsl:copy>
      <xsl:copy-of select="gmd:linkage" />
      <xsl:if test="not(gmd:linkage)">
        <xsl:message>No resource URL</xsl:message>
        <xsl:call-template name="addOnlineResourceLinkage"/>
      </xsl:if>
      <xsl:copy-of select="gmd:protocol" />
      <xsl:if test="not(gmd:protocol)">
        <xsl:message>No resource protocol</xsl:message>
        <xsl:call-template name="addOnlineResourceProtocol"/>
      </xsl:if>
      <xsl:copy-of select="gmd:name" />
      <xsl:if test="not(gmd:name)">
        <xsl:message>No resource name</xsl:message>
        <xsl:call-template name="addOnlineResourceName"/>
      </xsl:if>
      <xsl:copy-of select="gmd:description" />
      <xsl:if test="not(gmd:description)">
        <xsl:message>No resource description</xsl:message>
        <xsl:call-template name="addOnlineResourceDescription"/>
      </xsl:if>

    </xsl:copy>

  </xsl:template>

  <!-- elements to add -->

  <xsl:template name="addOnlineResourceName">
    <gmd:name>
       <gco:CharacterString/>
    </gmd:name>
  </xsl:template>

  <xsl:template name="addOnlineResourceDescription">
    <gmd:description>
      <gco:CharacterString/>
    </gmd:description>
  </xsl:template>
  
  <xsl:template name="addOnlineResourceLinkage">
    <gmd:linkage>
      <gmd:URL/>
    </gmd:linkage>
  </xsl:template>
  
  <xsl:template name="addOnlineResourceProtocol">
    <gmd:protocol>
      <gco:CharacterString/>
    </gmd:protocol>
  </xsl:template>

  <!-- Add gco:Boolean to gmd:pass with nilReason to work nicely in the editor,
    update-fixed-info.xsl should removed if empty to avoid xsd errors  -->
  <xsl:template match="gmd:pass[@gco:nilReason and not(gco:Boolean)]" priority="20">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <gco:Boolean>false</gco:Boolean>
    </xsl:copy>
  </xsl:template>

    <!-- Add gco:CharacterString child nodes to elements with gco:nilReason attributes so they display
    in the editor, then use update-fixed-info.xsl to get rid of them if not required, keep also gco:nilReason attribute -->
    <xsl:template match="//*[(@gco:nilReason='inapplicable' or @gco:nilReason='unknown') and not(gco:CharacterString) and name() != 'gmd:verticalElement' and name() != 'gmd:hierarchyLevelName']" priority="10">
      <xsl:copy>
        <xsl:apply-templates select="@*|*"/>
        <xsl:element name="gco:CharacterString"/>
      </xsl:copy>
    </xsl:template>

<!-- temporal extent -->
    <xsl:template name="addTimePeriodElement">
      <xsl:message>==== Adding time period element ====</xsl:message>
          <!-- <gml:TimePeriod gml:id="{generate-id()}"> -->
          <gml:TimePeriod gml:id="tp1">
            <gml:beginPosition/>
            <gml:endPosition/>
          </gml:TimePeriod>
  </xsl:template>

  <!-- copy everything else -->

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>

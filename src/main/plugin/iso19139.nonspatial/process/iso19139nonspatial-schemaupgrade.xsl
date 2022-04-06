<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:gml="http://www.opengis.net/gml/3.2"
    xmlns:srv="http://www.isotc211.org/2005/srv"
    xmlns:gmx="http://www.isotc211.org/2005/gmx"
    xmlns:gco="http://www.isotc211.org/2005/gco"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:geonet="http://www.fao.org/geonetwork"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:eamp="http://environment.data.gov.uk/eamp"
    exclude-result-prefixes="gml">
    
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    
    <!-- ================================================================= -->
    
    <!-- Template for converting to ISO19139 non-spatial -->
    
    <!-- ================================================================= -->
    
   
    
    
    <xsl:template match="*" priority="1">
        <xsl:element name="{name()}" namespace="{namespace-uri()}">
            <xsl:namespace name="gml" select="'http://www.opengis.net/gml/3.2'"/>
            <xsl:namespace name="srv" select="'http://www.isotc211.org/2005/srv'"/>
            <xsl:namespace name="gmx" select="'http://www.isotc211.org/2005/gmx'"/>
            <xsl:namespace name="gco" select="'http://www.isotc211.org/2005/gco'"/>
            <xsl:namespace name="xsi" select="'http://www.w3.org/2001/XMLSchema-instance'"/>
            <xsl:namespace name="xlink" select="'http://www.w3.org/1999/xlink'"/>
            <xsl:namespace name="gmd" select="'http://www.isotc211.org/2005/gmd'"/>
            <xsl:namespace name="xs" select="'http://www.w3.org/2001/XMLSchema'"/>
            <xsl:namespace name="eamp" select="'http://environment.data.gov.uk/eamp'"/>
            <xsl:namespace name="geonet" select="'http://www.fao.org/geonetwork'"/>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="@xsi:schemaLocation" priority="10"/>
    
    <!--  Change metadata standard name and version  -->
    <xsl:template match="//gmd:metadataStandardName"  priority="10">
        <xsl:message>=== Updating Metadata Standard Name</xsl:message>
        <gmd:metadataStandardName>
            <gco:CharacterString>ISO19139 non-spatial</gco:CharacterString>
        </gmd:metadataStandardName>
    </xsl:template>
    
    <xsl:template match="//gmd:metadataStandardVersion"  priority="10">
        <xsl:message>=== Updating Metadata Standard Version</xsl:message>
        <gmd:metadataStandardVersion>
            <gco:CharacterString>1.0</gco:CharacterString>
        </gmd:metadataStandardVersion>
        
    </xsl:template>
    
    <!--  Change hierarchy level and level name  -->
     <xsl:template match="//gmd:hierarchyLevel" priority="10">
          <xsl:message>=== Updating hierarchyLevel</xsl:message>
               <gmd:hierarchyLevel>
                   <gmd:MD_ScopeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode" codeListValue="nonGeographicDataset" codeSpace="ISOTC211/19115"/>
                </gmd:hierarchyLevel>
         <xsl:choose>
             <xsl:when test="not(following::gmd:hierarchyLevelName)">
                 <xsl:message>=== Adding missing hierarchyLevelName</xsl:message>
                 <gmd:hierarchyLevelName>
                     <gco:CharacterString>NonGeographicDataset</gco:CharacterString>
                 </gmd:hierarchyLevelName>
             </xsl:when>
             <xsl:otherwise>
                 <xsl:apply-templates select="gmd:hierarchyLevelName" />
             </xsl:otherwise>
         </xsl:choose>
    </xsl:template>

<!--    <xsl:template match="//gmd:hierarchyLevel[not(following::gmd:hierarchyLevelName)]" priority="10">
        <xsl:message>=== Adding missing hierarchyLevelName</xsl:message>
        <gmd:hierarchyLevelName>
            <gco:CharacterString>NonGeographicDataset</gco:CharacterString>
        </gmd:hierarchyLevelName>
    </xsl:template>-->
    
    <xsl:template match="//gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope" priority="10">
        <xsl:message>=== Updating Data Quality Scope Code</xsl:message>
        <gmd:scope>
            <gmd:DQ_Scope>
                <gmd:level>
                    <gmd:MD_ScopeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode"
                        codeListValue="dataset"
                        codeSpace="ISOTC211/19115"/>
                </gmd:level>
                <gmd:levelDescription>
                    <gmd:MD_ScopeDescription>
                        <gmd:other>
                            <gco:CharacterString>NonGeographicDataset</gco:CharacterString>
                        </gmd:other>
                    </gmd:MD_ScopeDescription>
                </gmd:levelDescription>
            </gmd:DQ_Scope>
        </gmd:scope>
    </xsl:template>

    <!-- make sure the OGL license is included and referenced correctly -->

    <xsl:template match="gmd:MD_LegalConstraints" priority="10">
        <xsl:message>=== Updating Legal Constraints</xsl:message>
        <gmd:MD_LegalConstraints>
          <gmd:useConstraints>
            <gmd:MD_RestrictionCode codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#MD_RestrictionCode" codeListValue="otherRestrictions" />
          </gmd:useConstraints>
          <gmd:otherConstraints>
            <gmx:Anchor xlink:href="http://reference.data.gov.uk/id/open-government-licence">Open Government Licence</gmx:Anchor>
          </gmd:otherConstraints>
          <gmd:otherConstraints>
            <gco:CharacterString>We simply ask that you acknowledge the copyright and the source of the data by including the following attribution statement: Contains OS data © Crown copyright and database right 2020 Contains Royal Mail data © Royal Mail copyright and Database right 2020 Contains National Statistics data © Crown copyright and database right 2020</gco:CharacterString>
          </gmd:otherConstraints>
      </gmd:MD_LegalConstraints>
      </xsl:template>
    
    
    <!-- ================================================================= -->
    
    <!-- remove resource constraints block containing eamp -->
    <xsl:template match="gmd:resourceConstraints[descendant::eamp:*]" priority="10">
        <xsl:message>=== Removing EAMP resource constraints blocks</xsl:message>
    </xsl:template>
    
    <!-- remove geographic element blocks that don't also contain a temporal extent-->
    <xsl:template match="//gmd:geographicElement" priority="20">
        <xsl:message>=== Removing geographic elements</xsl:message>
    </xsl:template>
    
       
    <!-- Copy timePeriod, with a nasty hack to update namespaces -->
    <xsl:template match="//*:TimePeriod" priority="30">
        <xsl:message>=== Matching timeperiod</xsl:message>
        <xsl:variable name="beginPosition" select="./*:beginPosition"/>
        <xsl:variable name="endPosition" select="./*:endPosition"/>
        <xsl:variable name="gmlID" select="@*:id"/>
        <xsl:variable name="position" select="./*:endPosition/@indeterminatePosition"/>
        
        <gml:TimePeriod gml:id="{$gmlID}">
            <gml:beginPosition><xsl:value-of select="$beginPosition"/></gml:beginPosition>
            <gml:endPosition indeterminatePosition="{$position}"><xsl:value-of select="$beginPosition"/></gml:endPosition>
        </gml:TimePeriod>
    </xsl:template>
    
    <!-- remove remaining empty extent blocks that don't contain temporal elements -->
        <xsl:template match="//gmd:extent[not(.//gmd:temporalElement) and not(.//*:TimePeriod)]" priority="10">
        <xsl:message>=== Removing empty extent blocks</xsl:message>
    </xsl:template>
       
    
    <!--  Remove gmd:referenceSystemInfo elements  -->
    <xsl:template match="//gmd:referenceSystemInfo" priority="10">
        <xsl:message>=== Removing reference system info</xsl:message>
    </xsl:template>
    
    <!--  Remove gmd:spatialRepresentationType elements  -->
    <xsl:template match="//gmd:spatialRepresentationType" priority="10">
        <xsl:message>=== Removing spatial representation type</xsl:message>
    </xsl:template>
    
    <!--  Remove geonet:* elements.  -->
    <xsl:template match="geonet:*" priority="10"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
  
    
</xsl:stylesheet>

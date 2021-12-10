gith<?xml version="1.0" encoding="UTF-8"?>

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
    exclude-result-prefixes="#all">
    
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    
    <!-- ================================================================= -->
    
    <!-- Template for converting to ISO19139 non-spatial -->
    
    <!-- ================================================================= -->
    
    
    
    
    <xsl:template match="*" priority="1">
        <xsl:element name="{name()}" namespace="{namespace-uri()}">
            <xsl:namespace name="gml" select="'http://www.opengis.net/gml'"/>
            <xsl:namespace name="srv" select="'http://www.isotc211.org/2005/srv'"/>
            <xsl:namespace name="gmx" select="'http://www.isotc211.org/2005/gmx'"/>
            <xsl:namespace name="gco" select="'http://www.isotc211.org/2005/gco'"/>
            <xsl:namespace name="xsi" select="'http://www.w3.org/2001/XMLSchema-instance'"/>
            <xsl:namespace name="xlink" select="'http://www.w3.org/1999/xlink'"/>
            <xsl:namespace name="gmd" select="'http://www.isotc211.org/2005/gmd'"/>
            <xsl:namespace name="xs" select="'http://www.w3.org/2001/XMLSchema'"/>
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
    <!-- Only if it doesn't already equal NonGeographicDataset -->
    <xsl:template match="//gmd:hierarchyLevel"  priority="10">
        <gmd:hierarchyLevel>
            <gmd:MD_ScopeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode" codeListValue="nonGeographicDataset" codeSpace="ISOTC211/19115"/>
        </gmd:hierarchyLevel>
    </xsl:template>
    
    <xsl:template match="//gmd:hierarchyLevelName"  priority="10">
        <gmd:hierarchyLevelName>
            <gco:CharacterString>NonGeographicDataset</gco:CharacterString>
        </gmd:hierarchyLevelName>
    </xsl:template>
    
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
    
    
    <!-- ================================================================= -->
    
    <!-- remove resource constraints block containing eamp -->
    <xsl:template match="gmd:resourceConstraints[descendant::eamp:*]" priority="10">
        <xsl:message>=== Removing EAMP resource constraints blocks</xsl:message>
    </xsl:template>
    
    <!-- remove geographic element blocks that don't also contain a temporal extent-->
    <xsl:template match="gmd:geographicElement" priority="20">
        <xsl:message>=== Removing geographic elements</xsl:message>
    </xsl:template>
    
    <!-- remove remaining empty extent blocks -->
    <xsl:template match="gmd:extent[not(descendant::gmd:temporalElement) and not(descendant::gml:TimePeriod)]" priority="10">
        <xsl:message>=== Removing empty extent blocks</xsl:message>
    </xsl:template>
    
    <!-- Update gml namespace references for time period-->
    <xsl:template match="gml:TimePeriod" xmlns:gml="http://www.opengis.net/gml/3.2" priority="10">
        <xsl:element name="{name()}" namespace="http://www.opengis.net/gml">
            <xsl:attribute name="gml:id" namespace="http://www.opengis.net/gml">1234</xsl:attribute>
            <!--<xsl:apply-templates select="*|@*"/>-->
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="gml:beginPosition" xmlns:gml="http://www.opengis.net/gml/3.2" priority="100">
        <xsl:element name="{name()}" namespace="http://www.opengis.net/gml">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="gml:endPosition" xmlns:gml="http://www.opengis.net/gml/3.2" priority="100">
        <xsl:variable name="position" select="@indeterminatePosition"/>
        <xsl:element name="{name()}" namespace="http://www.opengis.net/gml">
            <xsl:attribute name="indeterminatePosition"><xsl:value-of select="$position"/></xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    
    <!--  Remove gmd:referenceSystemInfo elements  -->
    <xsl:template match="gmd:referenceSystemInfo" priority="10">
        <xsl:message>=== Removing reference system info</xsl:message>
    </xsl:template>
    
    <!--  Remove gmd:spatialRepresentationType elements  -->
    <xsl:template match="gmd:spatialRepresentationType" priority="10">
        <xsl:message>=== Removing spatial representation type</xsl:message>
    </xsl:template>
    
    <!--  Remove geonet:* elements.  -->
    <xsl:template match="geonet:*" priority="10"/>
    
    <!--<xsl:template match="@*|node()">
        <xsl:copy  copy-namespaces="no">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>-->
    
</xsl:stylesheet>

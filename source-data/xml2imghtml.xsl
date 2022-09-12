<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei xs" version="2.0">
    <xsl:output encoding="UTF-8" method="html"/> 
    
    <!-- row -->
    <xsl:template match="row">
        <xsl:result-document method="text" encoding="utf-8" href="{id}_image.html"/>
            <div class="col image">
                <xsl:apply-templates/>
            </div>      
    </xsl:template>
     <xsl:template match="title"/>
    <xsl:template match="id">
            <img>
                <xsl:attribute name= "src">
                    <xsl:value-of select = "id"/>
                </xsl:attribute>
                <xsl:attribute name= "alt">
                    <xsl:value-of select = "title"/>
                </xsl:attribute>
            </img>
    </xsl:template>
    <xsl:template match="paper"/>
    <xsl:template match="state"/>
    <xsl:template match="course"/>
    <xsl:template match="course_en"/>
    <xsl:template match="ingredients"/>
    <xsl:template match="ingredients_en"/>
    <xsl:template match="ingredients_list_en"/>
    <xsl:template match="directions_en"/>
    <xsl:template match="title_en"/>
    <xsl:template match="tags_en"/>
    <xsl:template match="url"/>
    <xsl:template match="pdf_file_path"/>
    <xsl:template match="tags"/>
    <xsl:template match="ingredients_list"/>
    <xsl:template match="directions"/>
    
    <!--default that tells what elements are not defined in this document-->
    <xsl:template match="tei:*">
        <xsl:message>
            <xsl:text>unknown element: </xsl:text>
            <xsl:value-of select="local-name()"/>
        </xsl:message>
    </xsl:template>

</xsl:stylesheet>

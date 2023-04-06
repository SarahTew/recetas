<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
        <xsl:template match="row">
            <xsl:result-document method="text" encoding="utf-8" href="{id}.en.md">
                <xsl:call-template name="frontmatter"></xsl:call-template>
                <!--<xsl:apply-templates select="ingredient_list"></xsl:apply-templates>
                <xsl:text>&#10;</xsl:text>
                <xsl:apply-templates select="directions"></xsl:apply-templates>-->
            </xsl:result-document>
        </xsl:template>
    <xsl:template name="frontmatter">
        <xsl:text>---</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>id: </xsl:text>
        <xsl:value-of select="id"/>
        <xsl:text>&#10;</xsl:text>
       <xsl:text>title: </xsl:text>
        <xsl:value-of select="title_en"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>description: Recipes de las Américas</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>etiquettas: </xsl:text>
        <xsl:text>[</xsl:text>
        <xsl:apply-templates select="tags_en"/>
        <xsl:text>]</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>ingredientes: </xsl:text>
        <xsl:text>[</xsl:text>
        <xsl:apply-templates select="ingredients_en"/>
        <xsl:text>]</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>plato: </xsl:text>
        <xsl:text>[</xsl:text>
        <xsl:apply-templates select="course_en"/>
        <xsl:text>]</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>chronam: </xsl:text>
        <xsl:value-of select="url"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>jpg: </xsl:text>
        <xsl:value-of select="id"/>
        <xsl:text>.jpg</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>pdf: </xsl:text>
        <xsl:value-of select="id"/>
        <xsl:text>_en.pdf</xsl:text>
        <xsl:text>&#10;</xsl:text>
          <xsl:text>---</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>{{&lt; readFile file="./html/recipes/</xsl:text><xsl:value-of select="id"/><xsl:text>.en.html"&gt;}}</xsl:text>
    </xsl:template>
    <xsl:template match="ingredient_list_en">
        <xsl:for-each select="tokenize(.,';')">
            <xsl:text>- </xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
    </xsl:template>
 <xsl:template match="ingredients_en">
        <xsl:for-each select="tokenize(.,';')">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:text>"</xsl:text>
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="course_en">
        <xsl:for-each select="tokenize(.,';')">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:text>"</xsl:text>
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tags_en">
        <xsl:for-each select="tokenize(.,';')">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:text>"</xsl:text>
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei xs" version="2.0">
    <xsl:output encoding="UTF-8" method="html"/>
    <xsl:template match="tei:TEI">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- teiHeader: do not process -->
    <xsl:template match="tei:teiHeader"/>
    
    <!-- text -->
    <xsl:template match="tei:text">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- front: do not process -->
    <xsl:template match="tei:front"/>

    <!-- body -->
    <xsl:template match="tei:body">
        <div class="col transcription">
            <xsl:call-template name="letterhead"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!--back: do not process-->

    <xsl:template match="tei:back"/>

    <!-- lb -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>

    <!-- pb; select @facs image; select @n; added "begin page" text; @style allows styling in markup-->
    <xsl:template match="tei:pb">
        <p>
            <span class="pb">
                <br/>
                <xsl:text> [begin page </xsl:text>
                <xsl:value-of select="@n"/>
                <xsl:text>] </xsl:text>
            </span>
        </p>
    </xsl:template>

    <!--hi-->
    <xsl:template match="tei:hi">
        <span>
            <xsl:attribute name="class">
                <xsl:text>hi </xsl:text>
                <xsl:if test="@rend">
                    <xsl:value-of select="@rend"/>
                </xsl:if>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    <!--add-->
    <xsl:template match="tei:add">
        <span>
            <xsl:attribute name="class">
                <xsl:text>add</xsl:text>
                <xsl:text> </xsl:text>
                <xsl:value-of select="@place"/>
                <xsl:if test="@rend">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@rend"/>
                </xsl:if>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!--del-->
    <xsl:template match="tei:del">
        <span>
            <xsl:attribute name="class">
                <xsl:text>del </xsl:text>
                <xsl:if test="@rend">
                    <xsl:value-of select="@rend"/>
                </xsl:if>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!--ab-->
    <xsl:template match="tei:ab">
        <div>
            <xsl:attribute name="class">
                <xsl:text>ab</xsl:text>
                <xsl:if test="@type">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@type"/>
                </xsl:if>
                <xsl:if test="@rend">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@rend"/>
                </xsl:if>
            </xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--foreign-->
    <xsl:template match="tei:foreign">
        <xsl:apply-templates/>
    </xsl:template>
    
<!--seg-->
    <xsl:template match="tei:seg">
        <span>
            <xsl:attribute name="class">
                <xsl:text>seg</xsl:text>
                <xsl:if test="@type">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@type"/>
                </xsl:if>
                <xsl:if test="@rend">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@rend"/>
                </xsl:if>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- names -->
    <xsl:template match="tei:persName | tei:orgName | tei:placeName | tei:rs">
        <span class="{local-name()}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template
        match="tei:persName[@ref] | tei:orgName[@ref] | tei:placeName[@ref] | tei:rs[@ref]">
        <a class="wikidata" target="_blank" href="https://www.wikidata.org/wiki/{@ref}">
            <span class="{local-name()}">
                <xsl:apply-templates/>
            </span>
        </a>
    </xsl:template>

    <xsl:template match="tei:ptr">
        <xsl:variable name="note-num" select="count(preceding::tei:ptr) + 1"/>
        <a href="#n-{$note-num}" id="ns-{$note-num}">
            <span class="note-ref">
                <sup>
                    <xsl:value-of select="$note-num"/>
                </sup>
            </span>
        </a>
    </xsl:template>
    
    <!--letterhead-->
    <xsl:template name="letterhead">
        <xsl:apply-templates select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:ab"/>  
    </xsl:template>

    <!--default that tells what elements are not defined in this document-->
    <xsl:template match="tei:*">
        <xsl:message>
            <xsl:text>unknown element: </xsl:text>
            <xsl:value-of select="local-name()"/>
        </xsl:message>
    </xsl:template>

</xsl:stylesheet>

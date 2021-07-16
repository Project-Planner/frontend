<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:css="http://www.w3.org/TR/XSL-for-CSS">
    <xsl:template match="/">
    <html>
    <head></head>
    <body>
        <xsl:for-each select="user/items/calendar">
        <div id="mycalendars">
                        <input type="radio" name="showcalendarradiobuttons"><xsl:attribute name="id"><xsl:value-of select="@href"/></xsl:attribute><xsl:attribute name="value"><xsl:value-of select="@href"/></xsl:attribute></input>
                        <label><xsl:attribute name="for"><xsl:value-of select="@href"/></xsl:attribute><xsl:value-of select="@href"/></label>
        </div>
                    </xsl:for-each>
    </body>
    </html>
</xsl:template>
</xsl:stylesheet>
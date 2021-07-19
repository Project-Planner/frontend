<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:css="http://www.w3.org/TR/XSL-for-CSS">
    <xsl:template match="/">
        <html>
            <head>
                <script src="../js/main.js">
                    <link rel="stylesheet" href="../css/showCalendars.css" />
                </script>
            </head>
            <body>
                <xsl:for-each select="user/items/calendar">
                    <div id="mycalendars">
                        <a target="calendarFrame">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat('/me/c/', @href)"/>
                            </xsl:attribute>
                            <input type="radio" name="showcalendarradiobuttons">
                                <xsl:attribute name="id">
                                    <xsl:value-of select="@href"/>
                                </xsl:attribute>
                                <xsl:attribute name="value">
                                    <xsl:value-of select="@href"/>
                                </xsl:attribute>
                            </input>
                            <label>
                                <xsl:attribute name="for">
                                    <xsl:value-of select="@href"/>
                                </xsl:attribute>
                                <xsl:value-of select="@href"/>
                            </label>
                        </a>
                        <xsl:if test="@perm = 'owner'">
                            <xsl:variable name="dq">
                                <xsl:text>'</xsl:text>
                            </xsl:variable>
                            <xsl:variable name="callfnc">
                                <xsl:value-of select="concat(concat(concat(concat('setCalendarnameToShare(',$dq),@href), $dq),')')"/>
                            </xsl:variable>
                        &#160;&#160;&#160;
                            <a>
                                <xsl:attribute name="onclick">
                                    <xsl:value-of select="$callfnc"/>
                                </xsl:attribute>
                                <img src="../ressources/sharecalendar.svg" style="height: 10vh; cursor: pointer;"/>
                            </a>
                        </xsl:if>
                        <xsl:if test="@perm = 'owner'">
                            <xsl:variable name="dq">
                                <xsl:text>'</xsl:text>
                            </xsl:variable>
                            <xsl:variable name="callfnc">
                                <xsl:value-of select="concat(concat(concat(concat('setCalendarnameInDeleteCalendar(',$dq),@href), $dq),')')"/>
                            </xsl:variable>
                            &#160;&#160;&#160;
                            <a>
                                <xsl:attribute name="onclick">
                                    <xsl:value-of select="$callfnc"/>
                                </xsl:attribute>
                                <img src="../ressources/deletecalendar.svg" style="height: 10vh; cursor: pointer;"/>
                            </a>
                        </xsl:if>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:css="http://www.w3.org/TR/XSL-for-CSS">
    <xsl:template match="/">
        <xsl:variable name="sp">
            <xsl:text>'</xsl:text>
        </xsl:variable>
        <html>
            <head>
                <script src="/js/main.js">
                </script>
                <link rel="stylesheet" href="/css/showCalendars.css" />
            </head>
            <body>
                <label id="username">
                    <xsl:value-of select="user/name/@val"/>
                </label>
                <xsl:variable name="username">
                    <xsl:value-of select="/user/name/@val"/>
                </xsl:variable>
                <xsl:for-each select="user/items/calendar">
                    <div id="mycalendars">
                        <a target="calendarFrame">
                            <!--<xsl:attribute name="href">
                                <xsl:value-of select="concat('/me/c/', @href)"/>
                            </xsl:attribute>-->
                            <xsl:attribute name="onclick">
                                <xsl:value-of select="concat('changeCalendar(',$sp,'/me/c/',@href,$sp,')')"/>
                            </xsl:attribute>
                            <xsl:choose>
                                <xsl:when test="position() = 1">
                                    <input type="radio" name="showcalendarradiobuttons" checked="checked">
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="@href"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="@href"/>
                                        </xsl:attribute>
                                    </input>
                                </xsl:when>
                                <xsl:otherwise>
                                    <input type="radio" name="showcalendarradiobuttons">
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="@href"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="@href"/>
                                        </xsl:attribute>
                                    </input>
                                </xsl:otherwise>
                            </xsl:choose>
                            <label>
                                <xsl:attribute name="for">
                                    <xsl:value-of select="@href"/>
                                </xsl:attribute>
                                <xsl:value-of select="@href"/>
                            </label>
                        </a>
                        <xsl:if test="@perm = 'owner'">
                            <xsl:variable name="callfnc">
                                <xsl:value-of select="concat(concat(concat(concat('setCalendarnameToShare(',$sp),@href), $sp),')')"/>
                            </xsl:variable>
                        &#160;&#160;&#160;
                            <a>
                                <xsl:attribute name="onclick">
                                    <xsl:value-of select="$callfnc"/>
                                </xsl:attribute>
                                <img src="/ressources/sharecalendar.svg" style="height: 10vh; cursor: pointer; filter: invert(100%);"/>
                            </a>
                        </xsl:if>
                        <xsl:if test="@perm = 'owner'">
                            <xsl:variable name="callfnc">
                                <xsl:value-of select="concat(concat(concat(concat('setCalendarnameInDeleteCalendar(',$sp),@href), $sp),')')"/>
                            </xsl:variable>
                            <xsl:if test="position() > 1">
                            &#160;&#160;&#160;
                                <a>
                                    <xsl:attribute name="onclick">
                                        <xsl:value-of select="$callfnc"/>
                                    </xsl:attribute>
                                    <img src="/ressources/deletecalendar.svg" style="height: 10vh; cursor: pointer;  filter: invert(100%);"/>
                                </a>
                            </xsl:if>
                        </xsl:if>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
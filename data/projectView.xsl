<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:css="http://www.w3.org/TR/XSL-for-CSS">
    <xsl:variable name="weekDate" select="'1.1.1970'"/>
    <xsl:variable name="displayMode" select="'calender'"/>
    <!--displayModes: calender/project-->
    <xsl:variable name="calenderMode" select="'week'"/>
    <!--calenderModes: week/day/month-->
    <!-- calendarMode brauchen wir hier glaub ich nicht-->
    <xsl:output method="XML" encoding="utf-8" indent="yes"/>
    <!--als output sollen wir lt. rhoetig xml verwenden, die seite sieht bei mir aber damit genau gleich aus-->
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" href="../css/projectView.css"/>
                <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Code+Pro"/>
            </head>
            <body>
                <div>
                    <xsl:variable name="startwithoutzeros">
                        <xsl:call-template name="erliestStart">
                            <xsl:with-param name="path" select="calendar/items"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:variable name="start">
                        <xsl:choose>
                            <!--koennte man das mit nur zwei "when" testen einmal fuer monat und einmal fuer tag?-->
                            <xsl:when test="string-length(substring-before($startwithoutzeros, '.'))=1 and string-length(substring-before(substring-after($startwithoutzeros, '.'), '.'))=1">
                                <xsl:value-of select="concat(concat(concat(concat(concat(0, substring-before($startwithoutzeros, '.')), '.'), concat(0, substring-before(substring-after($startwithoutzeros, '.'), '.'))), '.'), substring-after(substring-after($startwithoutzeros, '.'), '.'))"/>
                            </xsl:when>
                            <xsl:when test="string-length(substring-before($startwithoutzeros, '.')) = 1 and string-length(substring-before(substring-after($startwithoutzeros, '.'), '.')) = 2">
                                <xsl:value-of select="concat(0, $startwithoutzeros)"/>
                            </xsl:when>
                            <xsl:when test="string-length(substring-before($startwithoutzeros, '.')) = 2 and string-length(substring-before(substring-after($startwithoutzeros, '.'), '.')) = 1">
                                <xsl:value-of select="concat(concat(concat(substring-before($startwithoutzeros, '.'), '.'), concat(0, substring-before(substring-after($startwithoutzeros, '.'), '.'))), substring-after(substring-after($startwithoutzeros, '.'), '.'))"/>
                            </xsl:when>
                            <xsl:when test="string-length(substring-before($startwithoutzeros, '.')) = 2 and string-length(substring-before(substring-after($startwithoutzeros, '.'), '.')) = 2">
                                <xsl:value-of select="$startwithoutzeros"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="end">
                        <xsl:call-template name="latestEnd">
                            <xsl:with-param name="path" select="calendar/items"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:variable name="earliestStartJulian">
                        <xsl:call-template name="calculate-julian-day">
                            <xsl:with-param name="date" select="$start"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:variable name="latestEndJulian">
                        <xsl:call-template name="calculate-julian-day">
                            <xsl:with-param name="date" select="$end"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <div>
                        <xsl:attribute name="style">
                            <xsl:variable name="diff" select="$latestEndJulian - $earliestStartJulian"/>
                            <xsl:variable name="testit">height: 100vh; width:
                                <xsl:value-of select="68.3 * ($diff + 1)"/>;
                            </xsl:variable>
                            <xsl:value-of select="$testit"/>
                        </xsl:attribute>
                        <xsl:call-template name="DrawBackgroundLinesAndHeadDate">
                            <xsl:with-param name="iterationtimes" select="$latestEndJulian - $earliestStartJulian"/>
                            <xsl:with-param name="date" select="$start"/>
                        </xsl:call-template>
                    </div>
                    <xsl:call-template name="DrawDivsInLines">
                        <xsl:with-param name="path" select="calendar/items"/>
                        <xsl:with-param name="startJulian" select="$earliestStartJulian"/>
                    </xsl:call-template>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template name="DrawBackgroundLinesAndHeadDate">
        <xsl:param name="iterationtimes"/>
        <xsl:param name="date"/>
        <div style="display: inline-block; align-self: auto; vertical-align: top;">
            <!--Insert Dates for header here-->
            <xsl:value-of select="concat(concat(substring-before($date, '.'), '.'), substring-before(substring-after($date, '.'), '.'))"/>
        </div>
        <div style="border-left: 1px solid black; height: 100vh; display: inline-block;"></div>
        <!--Vertical Seperation Lines-->
        <xsl:if test="$iterationtimes > 0">
            <xsl:variable name="nextdatewrongformat">
                <xsl:call-template name="next-day-date">
                    <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="nextdate" select="concat(concat(concat(concat(substring-after(substring-after($nextdatewrongformat,'-'),'-'), '.'), substring-before(substring-after($nextdatewrongformat, '-'),'-')),'.'), substring-before($nextdatewrongformat, '-'))"/>
            <!--output von next-day-date kann SEHR einfach angepasst werden, dann sparen wir uns diese verkettung-->
            <xsl:call-template name="DrawBackgroundLinesAndHeadDate">
                <xsl:with-param name="iterationtimes" select="$iterationtimes -1"/>
                <xsl:with-param name="date" select="$nextdate"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template name="erliestStart">
        <xsl:param name="path"/>
        <xsl:for-each select="$path/appointments/appointment | $path/milestones/milestone | $path/tasks/task | $path/tasks/task/subtasks/subtask">
            <xsl:sort order="ascending" select="substring-after(substring-after(startDate/@val | duedate/@val,'.'),'.')" data-type="number"/>
            <xsl:sort order="ascending" select="substring-before(substring-after(startDate/@val | duedate/@val, '.'), '.')" data-type="number"/>
            <xsl:sort order="ascending" select="substring-before(startDate/@val | duedate/@val, '.')"/>
            <xsl:if test="position() = 1">
                <xsl:value-of select="startDate/@val | duedate/@val"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="latestEnd">
        <xsl:param name="path"/>
        <xsl:for-each select="$path/appointments/appointment | $path/milestones/milestone | $path/tasks/task | $path/tasks/task/subtasks/subtask">
            <xsl:sort order="descending" select="substring-after(substring-after(startDate/@val | duedate/@val,'.'),'.')" data-type="number"/>
            <xsl:sort order="descending" select="substring-before(substring-after(startDate/@val | duedate/@val, '.'), '.')" data-type="number"/>
            <xsl:sort order="descending" select="substring-before(startDate/@val | duedate/@val, '.')"/>
            <xsl:if test="position() = 1">
                <xsl:value-of select="startDate/@val | duedate/@val"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="DrawDivsInLines">
        <xsl:param name="path"/>
        <xsl:param name="startJulian"/>
        <table style="width: 100vw; height: 100vh;  display: inline-block; left: 0; top: 0; margin: -98vh 0 0 0;">
            <xsl:for-each select="$path/appointments/appointment | $path/milestones/milestone | $path/tasks/task | $path/tasks/task/subtasks/subtask">
                <xsl:sort order="ascending" select="substring-after(substring-after(startDate/@val | duedate/@val, '.'), '.')" data-type="number"/>
                <xsl:sort order="ascending" select="substring-before(substring-after(startDate/@val | duedate/@val, '.'), '.')" data-type="number"/>
                <xsl:sort order="ascending" select="substring-before(startDate/@val | duedate/@val, '.')" data-type="number"/>
                <xsl:variable name="startDate">
                    <xsl:call-template name="calculate-julian-day">
                        <xsl:with-param name="date" select="startDate/@val | duedate/@val"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="endDate">
                    <xsl:call-template name="calculate-julian-day">
                        <xsl:with-param name="date" select="endDate/@val | duedate/@val"/>
                    </xsl:call-template>
                </xsl:variable>
                <tr style="height: 50px;">
                    <td>
                        <xsl:call-template name="drawDivsInOneLine">
                            <xsl:with-param name="length" select="$endDate - $startDate"/>
                            <xsl:with-param name="name" select="name/@val"/>
                            <xsl:with-param name="startJulian" select="$startJulian"/>
                        </xsl:call-template>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    <xsl:template name="drawDivsInOneLine">
        <xsl:param name="length"/>
        <xsl:param name="name"/>
        <xsl:param name="startJulian"/>
        <xsl:choose>
            <xsl:when test="$length>0">
                <div style="background-color: red;">
                    <!--wozu background color red? auf der seite seh ich nirgendswo red xd-->
                    <xsl:variable name="startDivJulian">
                        <xsl:call-template name="calculate-julian-day">
                            <xsl:with-param name="date" select="startDate/@val"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:variable name="diff">
                        <xsl:value-of select="$startDivJulian - $startJulian"/>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$diff = 0">
                            <!--wir koennten auch einen colspan verwenden um die länge von einem element über mehrere spalten zu ziehen, dann muessten wir aber die struktur der Tabelle aendern. dafuer wuerden wir dann aber auch nicht mehr so viele berechnungen machen muessen, und das ganze waere mehr responsive-->
                            <xsl:attribute name="style">
                                <xsl:variable name="testit">color: #5a5c5f; border-radius: 5px;width: calc(
                                    <xsl:value-of select="$length"/> * 56.12px + (
                                    <xsl:value-of select="$length"/> - 1) * 12.05px); background-color: #F7BFBF; margin-left: calc(
                                    <xsl:value-of select="$diff"/> * 56.12px + (
                                    <xsl:value-of select="$diff"/>) * 12.05px);
                                </xsl:variable>
                                <xsl:value-of select="$testit"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="style">
                                <xsl:variable name="testit">color: #5a5c5f; border-radius: 5px;width: calc(
                                    <xsl:value-of select="$length"/> * 56.12px + (
                                    <xsl:value-of select="$length"/>) * 12.05px); background-color: #F7BFBF; margin-left: calc(
                                    <xsl:value-of select="$diff"/> * 56.12px + (
                                    <xsl:value-of select="$diff"/> - 1) * 12.08px);
                                </xsl:variable>
                                <xsl:value-of select="$testit"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of select="$name"/>
                    <xsl:value-of select="name()"/>
                    <!--so können wir den typ herausfinden und dann entsprechend einfaerben-->
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div>
                    <xsl:variable name="startDivJulianDuedate">
                        <xsl:call-template name="calculate-julian-day">
                            <xsl:with-param name="date">
                                <xsl:value-of select="duedate/@val"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:variable name="offset" select="$startDivJulianDuedate - $startJulian"/>
                    <xsl:choose>
                        <xsl:when test="$offset = 0">
                            <xsl:attribute name="style">
                                <xsl:variable name="testit">border-radius: 5px;background-color: #ADD3F7; color: #5a5c5f; width: 56.12px; text-align: center; margin-left: calc(
                                    <xsl:value-of select="$offset"/> * 56.12px + (
                                    <xsl:value-of select="$offset"/>) * 12.05px);
                                </xsl:variable>
                                <xsl:value-of select="$testit"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="style">
                                <xsl:variable name="testit">border-radius: 5px;background-color: #ADD3F7; color: #5a5c5f; width: 68px; text-align: center; margin-left: calc(
                                    <xsl:value-of select="$offset"/> * 56.12px + (
                                    <xsl:value-of select="$offset"/> - 1) * 12.08px);
                                </xsl:variable>
                                <xsl:value-of select="$testit"/>
                            </xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:value-of select="$name"/>
                    <xsl:value-of select="name()"/>
                    <!--so können wir den typ herausfinden und dann entsprechend einfaerben-->
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="calculate-julian-day">
        <!--This method converts a date into an int in order to get the days between to dates-->
        <xsl:param name="date"/>
        <xsl:param name="day" select="substring-before($date,'.')"/>
        <xsl:param name="month" select="substring-before(substring-after($date,'.'),'.')"/>
        <xsl:param name="year" select="substring-after(substring-after($date,'.'),'.')"/>
        <xsl:variable name="a" select="floor((14 - $month) div 12)"/>
        <xsl:variable name="y" select="$year + 4800 - $a"/>
        <xsl:variable name="m" select="$month + 12 * $a - 3"/>
        <xsl:value-of select="$day + floor((153 * $m + 2) div 5) + $y * 365 + floor($y div 4) - floor($y div 100) + floor($y div 400) - 32045"/>
    </xsl:template>
    <xsl:template name="next-day-date">
        <xsl:param name="date"/>
        <xsl:variable name="old_year" select="substring-after(substring-after($date,'.'),'.')"/>
        <xsl:variable name="old_month" select="substring-before(substring-after($date,'.'),'.')"/>
        <xsl:variable name="old_day" select="substring-before($date,'.')"/>
        <xsl:variable name="year">
            <xsl:choose>
                <xsl:when test="$old_month='12' and $old_day='31'">
                    <xsl:value-of select="$old_year+1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$old_year"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="month">
            <xsl:choose>
                <xsl:when test="$old_day='31'">
                    <xsl:choose>
                        <xsl:when test="$old_month=1 or $old_month=3 or $old_month=5 or $old_month=7 or $old_month=8">
                            <xsl:text>0</xsl:text>
                            <xsl:value-of select="$old_month+1"/>
                        </xsl:when>
                        <!-- october -->
                        <xsl:when test="$old_month='10'">
                            <xsl:value-of select="$old_month+1"/>
                        </xsl:when>
                        <!-- december it is -->
                        <xsl:when test="$old_month='12'">
                            <xsl:text>01</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$old_month"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$old_day='30'">
                    <xsl:choose>
                        <xsl:when test="$old_month=4 or $old_month=6 or $old_month=9">
                            <xsl:if test="$old_month!=9">
                                <xsl:text>0</xsl:text>
                            </xsl:if>
                            <xsl:value-of select="$old_month+1"/>
                        </xsl:when>
                        <!-- november -->
                        <xsl:when test="$old_month='11'">
                            <xsl:value-of select="$old_month+1"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$old_month"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$old_day='28' and $old_month=2">
                    <xsl:text>03</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="string-length($old_month)=1">
                            <xsl:value-of select="concat(0,$old_month)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$old_month"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="day">
            <xsl:choose>
                <xsl:when test="number($old_month)!=number($month)">
                    <xsl:text>01</xsl:text>
                </xsl:when>
                <xsl:when test="number($old_day) &lt; 9">
                    <xsl:text>0</xsl:text>
                    <xsl:value-of select="$old_day+1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$old_day+1"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$year"/>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="$month"/>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="$day"/>
    </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:variable name="weekDate" select="'1.1.1970'"/>
    <xsl:variable name="displayMode" select="'calender'"/>
    <!--displayModes: calender/project-->
    <xsl:variable name="calenderMode" select="'week'"/>
    <!--calenderModes: week/day/month-->

    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" href="../css/projectView.css"/>
                <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Code+Pro"/>
            </head>
            <body>
                <div>
                    <xsl:call-template name="earliestappointment">
                    </xsl:call-template>
                    <div style="width: 67px; height: 10px; background-color: red; vertical-align: top;margin: 20 0 0 -78;padding: 0; display: inline-block;"></div>
                    <!--one column is 57 people in width-->
                    <xsl:call-template name="sortDates">
                        <xsl:with-param name="path" select="calendar/items"/>
                    </xsl:call-template>
                </div>
            </body>
        </html>
    </xsl:template>


    <xsl:template name="earliestappointment">
        <xsl:for-each select="calendar/items/appointments/appointment">
            <xsl:sort order="ascending" select="startDate/@val" data-type="date"/>
            <xsl:variable name="day" select="substring-before(startDate/@val,'.')"/>
            <xsl:variable name="month" select="substring-before(substring-after(startDate/@val,'.'),'.')"/>
            <div style="display: inline-block; align-self: auto; vertical-align: top;">
                <xsl:if test="string-length($day)=1">
                    <xsl:value-of select="concat('0',$day)"/>
                </xsl:if>
                <xsl:text>.</xsl:text>
                <xsl:if test="string-length($month)=1">
                    <xsl:value-of select="concat('0',$month)"/>
                </xsl:if>
            </div>
            <div style="border-left: 1px solid black; height: 100vh; display: inline-block;"></div>
        </xsl:for-each>
    </xsl:template>
    <!-->
    <xsl:template name="listing">
        <xsl:for-each select="calendar/items/appointments/appointment">
            <xsl:sort order="ascending" select="startDate/@val" data-type="date"/>
            <xsl:value-of select="startDate/@val"/>
            <xsl:text>___</xsl:text>
        </xsl:for-each>
        <xsl:for-each select="calendar/items/milestones/milestone">
            <xsl:sort order="ascending" select="duedate/@val" data-type="date"/>
            <xsl:value-of select="duedate/@val"/>
            <xsl:text>___</xsl:text>
        </xsl:for-each>
        <xsl:for-each select="calendar/items/tasks/task">
            <xsl:sort order="ascending" select="startdate/@val" data-type="date"/>
            <xsl:value-of select="startdate/@val"/>
            <xsl:text>___</xsl:text>
        </xsl:for-each>
    </xsl:template>
    <-->



        <xsl:template name="sortDates">
            <xsl:param name="path"/>
            <xsl:for-each select="$path/appointments/appointment | $path/milestones/milestone">
                <xsl:sort order="ascending" select="startDate/@val" data-type="date"/>
                <xsl:call-template name="calculate-julian-day">
                    <xsl:with-param name="date" select="startDate/@val"/>
                </xsl:call-template>
                <xsl:value-of select="startDate/@val"/>
                <xsl:text>----</xsl:text>
            </xsl:for-each>
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

    </xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:variable name="weekDate" select="'1.1.1970'"/>
    <xsl:variable name="displayMode" select="'calender'"/>
    <xsl:variable name="calendarID" select="calendar/id/@val"/>
    <!--displayModes: calender/project-->
    <xsl:output method="xml" encoding="utf-8" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="../css/projectView.css"/>
                <link rel="stylesheet" href="../css/master.css"/>
                <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Code+Pro"/>
            </head>
            <body>
                <xsl:variable name="startwithoutzeros">
                    <xsl:call-template name="erliestStart">
                        <xsl:with-param name="path" select="calendar/items"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="start">
                    <xsl:choose>
                        <!--koennte man das mit nur zwei "when" testen einmal fuer monat und einmal fuer tag?-->
                        <xsl:when test="string-length(substring-before($startwithoutzeros, '.'))=1 and string-length(substring-before(substring-after($startwithoutzeros, '.'), '.'))=1">
                            <xsl:value-of select="concat(0,substring-before($startwithoutzeros, '.'),'.',0,substring-after($startwithoutzeros, '.'))"/>
                        </xsl:when>
                        <xsl:when test="string-length(substring-before($startwithoutzeros, '.')) = 1 and string-length(substring-before(substring-after($startwithoutzeros, '.'), '.')) = 2">
                            <xsl:value-of select="concat(0, $startwithoutzeros)"/>
                        </xsl:when>
                        <xsl:when test="string-length(substring-before($startwithoutzeros, '.')) = 2 and string-length(substring-before(substring-after($startwithoutzeros, '.'), '.')) = 1">
                            <xsl:value-of select="concat(substring-before($startwithoutzeros, '.'), '.',0,substring-after($startwithoutzeros, '.'))"/>
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
                <table>
                    <tr>
                        <xsl:call-template name="DrawBackgroundLinesAndHeadDate">
                            <xsl:with-param name="iterationtimes" select="$latestEndJulian - $earliestStartJulian"/>
                            <xsl:with-param name="date" select="$start"/>
                        </xsl:call-template>
                    </tr>
                    <xsl:call-template name="DrawDivsInLines">
                        <xsl:with-param name="path" select="calendar/items"/>
                        <xsl:with-param name="startJulian" select="$earliestStartJulian"/>
                        <xsl:with-param name="endJulian" select="$latestEndJulian"/>
                    </xsl:call-template>
                </table>
                <div id ="EditItemView">
                    <iframe class="editItem" id="editItem" name="editItem"  src="../html/createEntry.html"></iframe>
                </div>
                <script>function hideEditItemView(){
               document.getElementById("EditItemView").style.display = "none";    
                location.reload();      
            }  
            </script>
            </body>
        </html>
    </xsl:template>
    <xsl:template name="DrawBackgroundLinesAndHeadDate">
        <xsl:param name="iterationtimes"/>
        <xsl:param name="date"/>
        <th>
            <!--Insert Dates for header here-->
            <xsl:value-of select="concat(concat(substring-before($date, '.'), '.'), substring-before(substring-after($date, '.'), '.'))"/>
        </th>
        <xsl:if test="$iterationtimes > 0">
            <xsl:variable name="nextdate">
                <xsl:call-template name="next-day-date">
                    <xsl:with-param name="date" select="$date"/>
                </xsl:call-template>
            </xsl:variable>
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
            <xsl:sort order="descending" select="substring-after(substring-after(endDate/@val | duedate/@val,'.'),'.')" data-type="number"/>
            <xsl:sort order="descending" select="substring-before(substring-after(endDate/@val | duedate/@val, '.'), '.')" data-type="number"/>
            <xsl:sort order="descending" select="substring-before(endDate/@val | duedate/@val, '.')"/>
            <xsl:if test="position() = 1">
                <xsl:value-of select="endDate/@val | duedate/@val"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="DrawDivsInLines">
        <xsl:param name="path"/>
        <xsl:param name="startJulian"/>
        <xsl:param name="endJulian"/>
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
            <tr>
                <xsl:call-template name="drawDivsInOneLine">
                    <xsl:with-param name="length" select="$endDate - $startDate"/>
                    <xsl:with-param name="name" select="name/@val"/>
                    <xsl:with-param name="startJulian" select="$startJulian"/>
                    <xsl:with-param name="endJulian" select="$endJulian"/>
                    <xsl:with-param name ="id" select="@id"></xsl:with-param>
                </xsl:call-template>
            </tr>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="drawDivsInOneLine">
        <xsl:param name="length"/>
        <xsl:param name="name"/>
        <xsl:param name="startJulian"/>
        <xsl:param name="endJulian"/>
        <xsl:param name="id"/>
        <xsl:variable name="startDivJulian">
            <xsl:call-template name="calculate-julian-day">
                <xsl:with-param name="date" select="startDate/@val | duedate/@val"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="offsetToBeginnig">
            <xsl:value-of select="$startDivJulian - $startJulian"/>
        </xsl:variable>
        <xsl:call-template name="insertEmptyTD">
            <xsl:with-param name ="TDCount" select="$offsetToBeginnig"></xsl:with-param>
        </xsl:call-template>
        <td>
            <xsl:variable name="type" select="name()"></xsl:variable>
            <xsl:attribute name="class" >
                <xsl:value-of select="$type"></xsl:value-of>
                <xsl:text > elementTD</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="colspan" >
                <xsl:value-of select="$length+1"></xsl:value-of>
            </xsl:attribute>
            <a>
                <xsl:attribute name="onclick">
                    <xsl:variable name="apostrophe">'</xsl:variable>
                    <xsl:value-of select="concat('showEditItemView(',$apostrophe,$id,$apostrophe,',',$apostrophe,$calendarID,$apostrophe,')')"></xsl:value-of>
                </xsl:attribute>
                <xsl:value-of select="$name"></xsl:value-of>
            </a>
            <script>function showEditItemView(id,calendarID){
               
               document.getElementById("EditItemView").style.display = "block";  
               var iframe = document.getElementById('editItem');
                iframe.src = iframe.src; 
                document.getElementById('editItem').src= "/me/c/"+calendarID+"?mode=edit;id="+id;
                
               
                }
            </script>
        </td>
        <xsl:call-template name="insertEmptyTD">
            <xsl:with-param name ="TDCount" select="$endJulian - $startDivJulian - $length"></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="insertEmptyTD">
        <xsl:param name="TDCount"/>
        <xsl:if test="$TDCount > 0">
            <td>
        </td>
            <xsl:call-template name="insertEmptyTD">
                <xsl:with-param name="TDCount" select="$TDCount -1"/>
            </xsl:call-template>
        </xsl:if>
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
        <xsl:value-of select="$day"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="$month"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="$year"/>
    </xsl:template>
</xsl:stylesheet>
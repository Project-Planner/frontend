<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:variable name="displayMode" select="'calender'"/>
    <!--displayModes: calender/project-->
    <xsl:variable name="id" select="22"/>
    <!--hier id des anzuzeigenden Elements setzen-->
    <xsl:output method="XML" encoding="utf-8"/>
    <xsl:template match="/">
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <link rel="stylesheet" href="../css/mainPage.css"/>
                <link rel="stylesheet" href="../css/master.css"/>
                <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Code+Pro"/>
            </head>
            <body>
                <xsl:variable name="type">
                    <xsl:call-template name="getType">
                       
                    </xsl:call-template>
                </xsl:variable>
                <xsl:if test="not ( $type = 'milestone' )">
                    <xsl:call-template name="showNormalview">
                        
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="$type = 'milestone'">
                    <xsl:call-template name="showMilestoneView">
                    </xsl:call-template>
                </xsl:if>
            </body>
        </html>
    </xsl:template>
    <xsl:template name = "formatDate">
        <xsl:param name="date"></xsl:param>
        <xsl:variable name = "dateWithZeros">
            <xsl:call-template name="addZerosToDate">
                <xsl:with-param name="date" select="$date"></xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name = "day" select="substring-before($dateWithZeros,'.')"></xsl:variable>
        <xsl:variable name = "month" select="substring-before(substring-after($dateWithZeros,'.'),'.')"></xsl:variable>
        <xsl:variable name = "year" select="substring-after(substring-after($dateWithZeros,'.'),'.')"></xsl:variable>
        <xsl:value-of select="$year"/>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="$month"/>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="$day"/>
    </xsl:template>
    <xsl:template name="addZerosToDate">
        <xsl:param name="date"></xsl:param>
        <xsl:choose>
            <xsl:when test="string-length(substring-before($date, '.'))=1 and string-length(substring-before(substring-after($date, '.'), '.'))=1">
                <xsl:value-of select="concat(0,substring-before($date, '.'),'.',0,substring-after($date, '.'))"/>
            </xsl:when>
            <xsl:when test="string-length(substring-before($date, '.')) = 1 and string-length(substring-before(substring-after($date, '.'), '.')) = 2">
                <xsl:value-of select="concat(0, $date)"/>
            </xsl:when>
            <xsl:when test="string-length(substring-before($date, '.')) = 2 and string-length(substring-before(substring-after($date, '.'), '.')) = 1">
                <xsl:value-of select="concat(substring-before($date, '.'), '.',0,substring-after($date, '.'))"/>
            </xsl:when>
            <xsl:when test="string-length(substring-before($date, '.')) = 2 and string-length(substring-before(substring-after($date, '.'), '.')) = 2">
                <xsl:value-of select="$date"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="addZerosToTime">
        <xsl:param name="time"></xsl:param>
        <xsl:choose>
            <xsl:when test="string-length(substring-before($time, ':'))=1 and string-length(substring-after($time, ':'))=2 ">
                <xsl:value-of select="concat(0, $time)"/>
            </xsl:when>
            <xsl:when test="string-length(substring-before($time, ':'))=2 and string-length(substring-after($time, ':'))=1 ">
                <xsl:value-of select="concat(substring-before($time, ':'),':' ,0,substring-after($time, ':'))"/>
            </xsl:when>
            <xsl:when test="string-length(substring-before($time, ':'))=1 and string-length(substring-after($time, ':'))=1 ">
                <xsl:value-of select="concat(0,substring-before($time, ':'),':' ,0,substring-after($time, ':'))"/>
            </xsl:when>
            <xsl:when test="string-length(substring-before($time, ':'))=2 and string-length(substring-after($time, ':'))=2 ">
                <xsl:value-of select="$time"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="getType">
        <xsl:for-each select="calendar/items/appointments/appointment | calendar/items/milestones/milestone | calendar/items/tasks/task | calendar/items/tasks/task/subtasks/subtask">
            <xsl:if test="@id = $id">
                <xsl:value-of select="name()"></xsl:value-of>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="showNormalview">
        <xsl:for-each select="calendar/items/appointments/appointment  | calendar/items/tasks/task | calendar/items/tasks/task/subtasks/subtask">
            <xsl:if test="@id = $id">
                <xsl:value-of select="duetime/@val"></xsl:value-of>
                <form class="entry" action="" method="post">
                    <div>
                        <label for="relation">Zu Projekt hinzufügen: </label>
                    </div>
                    <div>
                        <label for="name">Name</label>
                        <input type="text" id="name" name="name" maxlength="250">
                            <xsl:attribute name ="value">
                                <xsl:value-of select="name/@val"></xsl:value-of>
                            </xsl:attribute>
                        </input>
                    </div>
                    <div>
                        <label for="datef">Datum von:</label>
                        <input type="date" id="datef" name="datef">
                            <xsl:variable name="date">
                                <xsl:value-of select="startDate/@val"></xsl:value-of>
                            </xsl:variable>
                            <xsl:variable name="dateFormated">
                                <xsl:call-template name="formatDate">
                                    <xsl:with-param name="date" select="$date"></xsl:with-param>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:attribute name="value">
                                <xsl:value-of select="$dateFormated"></xsl:value-of>
                            </xsl:attribute>
                        </input>
                    </div>
                    <div>
                        <label for="datet">Datum bis:</label>
                        <input type="date" id="datet" name="datet">
                            <xsl:variable name="date">
                                <xsl:value-of select="endDate/@val"></xsl:value-of>
                            </xsl:variable>
                            <xsl:variable name="dateFormated">
                                <xsl:call-template name="formatDate">
                                    <xsl:with-param name="date" select="$date"></xsl:with-param>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:attribute name="value">
                                <xsl:value-of select="$dateFormated"></xsl:value-of>
                            </xsl:attribute>
                        </input>
                    </div>
                    <div>
                        <label for="timef">Zeit von:</label>
                        <input type="time" id="timef" name="timef" >
                            <xsl:attribute name="value">
                                <xsl:variable name="timeWithoutZeros">
                                    <xsl:value-of select="startTime/@val"></xsl:value-of>
                                </xsl:variable>
                                <xsl:variable name="timeWithZeros">
                                    <xsl:call-template name="addZerosToTime">
                                        <xsl:with-param name="time" select="$timeWithoutZeros">
                                        </xsl:with-param>
                                    </xsl:call-template>
                                </xsl:variable>
                                <xsl:value-of select="$timeWithZeros"></xsl:value-of>
                            </xsl:attribute>
                        </input>
                    </div>
                    <div>
                        <label for="timet">Zeit bis:</label>
                        <input type="time" id="timet" name="timet">
                            <xsl:attribute name="value">
                                <xsl:variable name="timeWithoutZeros">
                                    <xsl:value-of select="endTime/@val"></xsl:value-of>
                                </xsl:variable>
                                <xsl:variable name="timeWithZeros">
                                    <xsl:call-template name="addZerosToTime">
                                        <xsl:with-param name="time" select="$timeWithoutZeros">
                                        </xsl:with-param>
                                    </xsl:call-template>
                                </xsl:variable>
                                <xsl:value-of select="$timeWithZeros"></xsl:value-of>
                            </xsl:attribute>
                        </input>
                    </div>
                    <div>
                        <div>
                            <label for="desc">Beschreibung:</label>
                            <textarea name="desc" rows="8" cols="40" placeholder="max 250 Zeichen">
                                <xsl:value-of select="desc"></xsl:value-of>
                            </textarea>
                        </div>
                        <div>
                            <input type="submit" name="" value="Save"/>
                        </div>
                        <div>
                            <input type="submit" name="" value="Delete"/>
                        </div>
                        <!-- Abbrechen fehlt-->
                    </div>
                </form>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="showMilestoneView">
        <xsl:for-each select=" calendar/items/milestones/milestone">
            <xsl:if test="@id = $id">
                <form class="entry" action="" method="post">
                    <div>
                        <label for="relation">Zu Projekt hinzufügen: </label>
                    </div>
                    <div>
                        <label for="name">Name</label>
                        <input type="text" id="name" name="name" maxlength="250">
                            <xsl:attribute name ="value">
                                <xsl:value-of select="name/@val"></xsl:value-of>
                            </xsl:attribute>
                        </input>
                    </div>
                    <div>
                        <label for="datef">Datum:</label>
                        <input type="date" id="datef" name="datef">
                            <xsl:variable name="date">
                                <xsl:value-of select="duedate/@val"></xsl:value-of>
                            </xsl:variable>
                            <xsl:variable name="dateFormated">
                                <xsl:call-template name="formatDate">
                                    <xsl:with-param name="date" select="$date"></xsl:with-param>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:attribute name="value">
                                <xsl:value-of select="$dateFormated"></xsl:value-of>
                            </xsl:attribute>
                        </input>
                    </div>
                    <div>
                        <label for="timef">Zeit:</label>
                        <input type="time" id="timef" name="timef" >
                            <xsl:attribute name="value">
                                <xsl:variable name="timeWithoutZeros">
                                    <xsl:value-of select="duetime/@val"></xsl:value-of>
                                </xsl:variable>
                                <xsl:variable name="timeWithZeros">
                                    <xsl:call-template name="addZerosToTime">
                                        <xsl:with-param name="time" select="$timeWithoutZeros">
                                        </xsl:with-param>
                                    </xsl:call-template>
                                </xsl:variable>
                                <xsl:value-of select="$timeWithZeros"></xsl:value-of>
                            </xsl:attribute>
                        </input>
                    </div>
                    <div>
                        <label for="desc">Beschreibung:</label>
                    </div>
                    <div>
                        <textarea name="desc" rows="8" cols="40" placeholder="max 250 Zeichen">
                            <xsl:value-of select="desc"></xsl:value-of>
                        </textarea>
                    </div>
                    <div>
                        <input type="submit" name="" value="Save"/>
                        <!-- Abbrechen fehlt-->
                    </div>
                    <div>
                        <input type="submit" name="" value="Delete"/>
                    </div>
                </form>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
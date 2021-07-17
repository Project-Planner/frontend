<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:css="http://www.w3.org/TR/XSL-for-CSS">
    <xsl:template match="/">
        <html>
            <head>
                <style>
                    body{margin:0;padding:0;}
                    #confirmdeletecalendar {
                        width: 100vw;
                        height: 100vh;
                        background-color: gray;
                        visibility: hidden;
                        opacity: 0;
                        z-index: 100000;
                        position: absolute;
                        left: 0;
                        top: 0;
                    }
                    #confirmdeletecalendar:target{
                        visibility: visible;
                        opacity: 0.8;
                    }
                    .deletecalendarbox {
                        background-color: #AAAAAA;
                        width: 42vw;
                        height: 10vh;
                        margin: auto;
                        margin-top: 40vh;
                        border-radius: 5px;
                        box-shadow: 0 0 2px black;
                        position: absolute;
                        left: 29vw;
                      }
                      .deletecalendartext {
                        color: #333333;
                        display: inline;
                        font-size: 1.8vh;
                      }
            </style>
                <script src="../js/main.js">
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
                        </a>
                        <label>
                            <xsl:attribute name="for">
                                <xsl:value-of select="@href"/>
                            </xsl:attribute>
                            <xsl:value-of select="@href"/>
                        </label>
                        <xsl:if test="@perm = 'owner'">&#160;&#160;&#160;
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="concat('/me/c/', @href)"/>
                                </xsl:attribute>
                                <img src="../ressources/sharecalendar.svg" style="height: 10vh;"/>
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
                            <script type="text/javascript">
                function setCalendarnameInDeleteCalendar(name){
                    parent.document.getElementById("deletecalendarcalendarname").textContent = name; //Sets the calendar name of the element in mainPage.html
                    parent.window.location.href = parent.window.location.href + "#deletecalendar";  //Appends #deletecalendar to the url to show the deletecalendar dialog
                    parent.document.getElementById("deletecalendarform").action = "/me/c/"+name;
                    parent.document.getElementById("deletecalendarform").href = "/me/c/"+name;
                    }
                </script>
                            <a>
                                <xsl:attribute name="onclick">
                                    <xsl:value-of select="$callfnc"/>
                                </xsl:attribute>
                                <img src="../ressources/deletecalendar.svg" style="height: 10vh;"/>
                            </a>
                        </xsl:if>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
<!--<form method="delete" style="display: inline-block;">
                                <xsl:attribute name="action">
                                    <xsl:value-of select="concat('/me/c/', @href)"/>
                                </xsl:attribute><xsl:attribute name="href">
                                    <xsl:value-of select="concat('/me/c/', @href)"/>
                                </xsl:attribute>-->
<!--<div class="deletecalendarbox">
                                        <div class="deletecalendartext">Bist du dir sicher, dass du deinen Kalender
                                            <div style="color: #333333;
                                            display: inline;
                                            font-size: 1.8vh; font-weight: 800;">
                                                <xsl:value-of select="@href"/>
                                            </div>&#160;löschen möchtest?
                                        </div>
                                        <br/>
                                        <input type="submit" value="Ja"/>
                                        <a href="">
                                            <input type="button" value="Nein"/>
                                        </a>
                                    </div>-->
<!--<xsl:attribute name="action">
                                <xsl:value-of select="concat('/me/c/', @href)"/>
                            </xsl:attribute>
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat('/me/c/', @href)"/>
                            </xsl:attribute>-->
<cfoutput>
<ul class="nav-list nav">
   <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
    <li class="nav-item dropdown-toggle"><a class="nav-link" href="/program-info">Program Info</a>
        <ul class="dropdown-menu dropdown-menu-lg container-fluid">
            <cfset feed = $.getBean('feed').loadBy(name='GeneralPgSubmenuProgramsNavItem')>
            <cfset it = feed.getIterator()>
            <cfif it.hasNext()>
            <div class="row">
              <div class="col-sm-4">
                <li class="sub-nav-header">Program Info</li>
                <cfloop condition="it.hasNext()">
                <cfset item = it.next()>
                   <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                     <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                     <!--- This is where you can specify how deep you want to go  --->
                     #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                   </li>
                </cfloop>
                </cfif>
               </div>
                <div class="col-sm-4">
                    <cfset feed = $.getBean('feed').loadBy(name='CompRulesPgSubmenuProgramsNavItem')>
                    <cfset it = feed.getIterator()>
                    <cfif it.hasNext()>
                    <li class="sub-nav-header">Region & Competition Rules</li>
                   <cfloop condition="it.hasNext()">
                   <cfset item = it.next()>
                    <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                        <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                        <!--- This is where you can specify how deep you want to go  --->
                        #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                     </li>
                   </cfloop>
                   </cfif>
                </div>
                <div class="col-sm-4">
                    <cfset feed = $.getBean('feed').loadBy(name='AddInfoProgramSubNavItem')>
                    <cfset it = feed.getIterator()>
                    <cfif it.hasNext()>
                    <li class="sub-nav-header">Additional Info</li>
                   <cfloop condition="it.hasNext()">
                   <cfset item = it.next()>
                    <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                        <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                        <!--- This is where you can specify how deep you want to go  --->
                        #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                    </li>
                   </cfloop>
                   </cfif>
                </div>
                <div class="col-sm-4">
                    <cfset feed = $.getBean('feed').loadBy(name='AddProgramsProgramSubNavItem')>
                    <cfset it = feed.getIterator()>
                    <cfif it.hasNext()>
                    <li class="sub-nav-header">More Programs</li>
                   <cfloop condition="it.hasNext()">
                   <cfset item = it.next()>
                    <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                        <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                        <!--- This is where you can specify how deep you want to go  --->
                        #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                     </li>
                   </cfloop>
                   </cfif>
                </div>
              </div>
        </ul>
    </li>
    <li class="nav-item dropdown-toggle"><a class="nav-link" href="/register">Register</a>
        <ul class="dropdown-menu">
        <cfset feed = $.getBean('feed').loadBy(name='RegistrationSubNavItems')>
        <cfset it = feed.getIterator()>
        <cfif it.hasNext()>
        <cfloop condition="it.hasNext()">
            <cfset item = it.next()>
            <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                <a href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                <!--- This is where you can specify how deep you want to go  --->
                #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
            </li>
        </cfloop>
        </cfif>
        </ul>
    </li>
    <li class="nav-item dropdown-toggle"><a class="nav-link" href="/coach">Coaches</a>
        <ul class="dropdown-menu">
            <cfset feed = $.getBean('feed').loadBy(name='CoachSubNavItem')>
            <cfset it = feed.getIterator()>
            <cfif it.hasNext()>
            <cfloop condition="it.hasNext()">
            <cfset item = it.next()>
                <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                    <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                    #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                </li>
            </cfloop>
            </cfif>
        </ul>
    </li>
    <li class="nav-item dropdown-toggle"><a class="nav-link" href="/referee">Referees</a>
        <ul class="dropdown-menu">
            <cfset feed = $.getBean('feed').loadBy(name='RefSubNavItem')>
            <cfset it = feed.getIterator()>
            <cfif it.hasNext()>
            <cfloop condition="it.hasNext()">
            <cfset item = it.next()>
                <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                    <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                    #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                </li>
            </cfloop>
            </cfif>
        </ul>
    </li>
    <li class="nav-item dropdown-toggle"><a class="nav-link" href="/volunteer">Volunteer</a>
        <ul class="dropdown-menu">
            <cfset feed = $.getBean('feed').loadBy(name='VolSubNavItem')>
            <cfset it = feed.getIterator()>
            <cfif it.hasNext()>
            <cfloop condition="it.hasNext()">
            <cfset item = it.next()>
                <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                    <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                    #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                </li>
            </cfloop>
            </cfif>
        </ul>
    </li>
    <li class="nav-item dropdown-toggle"><a class="nav-link" href="/schedules">Schedules / Fields</a>
        <ul class="dropdown-menu">
        <cfset feed = $.getBean('feed').loadBy(name='SchedulesSubNavItem')>
        <cfset it = feed.getIterator()>
        <cfif it.hasNext()>
        <cfloop condition="it.hasNext()">
        <cfset item = it.next()>
            <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
            </li>
        </cfloop>
        </cfif>
        </ul>
    </li>

    <li class="nav-item dropdown-toggle"><a class="nav-link" href="/competitive-programs">Competitive Programs</a>
        <ul class="dropdown-menu dropdown-menu-lg container-fluid">
            <cfset feed = $.getBean('feed').loadBy(name='PostSeasonSubNavItem')>
            <cfset it = feed.getIterator()>
            <cfif it.hasNext()>
            <div class="row">
              <div class="col-sm-4">
                <li class="sub-nav-header">Post-Season</li>
                <cfloop condition="it.hasNext()">
                <cfset item = it.next()>
                   <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                     <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                     <!--- This is where you can specify how deep you want to go  --->
                     #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                   </li>
                   </cfloop>
                   </cfif>
                </div>
                <div class="col-sm-4">
                    <cfset feed = $.getBean('feed').loadBy(name='ExtraSubNavItem')>
                    <cfset it = feed.getIterator()>
                    <cfif it.hasNext()>
                    <li class="sub-nav-header">Extra</li>
                   <cfloop condition="it.hasNext()">
                   <cfset item = it.next()>
                    <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                        <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                        <!--- This is where you can specify how deep you want to go  --->
                        #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                     </li>
                   </cfloop>
                   </cfif>
                </div>
                <div class="col-sm-4">
                    <cfset feed = $.getBean('feed').loadBy(name='AllianceSubNavItem')>
                    <cfset it = feed.getIterator()>
                    <cfif it.hasNext()>
                    <li class="sub-nav-header">Alliance</li>
                   <cfloop condition="it.hasNext()">
                   <cfset item = it.next()>
                    <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                        <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                        <!--- This is where you can specify how deep you want to go  --->
                        #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                    </li>
                   </cfloop>
                   </cfif>
                </div>
                <div class="col-sm-4">
                    <cfset feed = $.getBean('feed').loadBy(name='UnitedSubNavItem')>
                    <cfset it = feed.getIterator()>
                    <cfif it.hasNext()>
                    <li class="sub-nav-header">United</li>
                   <cfloop condition="it.hasNext()">
                   <cfset item = it.next()>
                    <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                        <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                        <!--- This is where you can specify how deep you want to go  --->
                        #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                     </li>
                   </cfloop>
                   </cfif>
                </div>
              </div>
        </ul>
    </li>

    <li class="nav-item dropdown-toggle"><a class="nav-link" href="/cup">Sportsmanship Cup</a>
        <ul class="dropdown-menu dropdown-menu-lg container-fluid dropdown-left">
                    <cfset feed = $.getBean('feed').loadBy(name='GeneralCupSubNavItem')>
                    <cfset it = feed.getIterator()>
                    <cfif it.hasNext()>
                    <div class="row">
                      <div class="col-sm-4">
                        <li class="sub-nav-header">General</li>
                        <cfloop condition="it.hasNext()">
                        <cfset item = it.next()>
                           <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                             <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                             <!--- This is where you can specify how deep you want to go  --->
                             #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                           </li>
                        </cfloop>
                        </cfif>
                       </div>
                    <!--    <div class="col-sm-4">
                        <cfset feed = $.getBean('feed').loadBy(name='TeamsCupSubNavItem')>
                        <cfset it = feed.getIterator()>
                        <cfif it.hasNext()>
                          <li class="sub-nav-header">Teams</li>
                           <cfloop condition="it.hasNext()">
                           <cfset item = it.next()>
                             <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                                <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                                <!--- This is where you can specify how deep you want to go  --->
                                #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                             </li>
                           </cfloop>
                           </cfif>
                        </div> -->
                        <div class="col-sm-4">
                            <cfset feed = $.getBean('feed').loadBy(name='refereesCupSubNavItem')>
                            <cfset it = feed.getIterator()>
                            <cfif it.hasNext()>
                            <li class="sub-nav-header">Referees</li>
                           <cfloop condition="it.hasNext()">
                           <cfset item = it.next()>
                            <li<cfif $.content('contentid') eq item.getContentID()> class="active current"</cfif>>
                                <a target="#item.getTarget()#" href="#item.getURL()#">#HTMLEditFormat(item.getMenuTitle())#</a>
                                <!--- This is where you can specify how deep you want to go  --->
                                #$.dspNestedNav(contentID=item.getContentID(), viewDepth=2)#
                            </li>
                           </cfloop>
                           </cfif>
                        </div>
                      </div>
                </ul>
    </li>
</ul>
</cfoutput>

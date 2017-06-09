<?xml version="1.0"?>
<workflow name="loopWorkflow">
    <options>
        <enabled>true</enabled>
        <scheduler type="cron" autorun="false">
            <month>1-2</month>
            <day>*</day>
            <hour>*</hour>
            <second>*/10</second>
        </scheduler>
    </options>
    <steps>
        <step id="start">
            <action>returnPlusOne</action>
            <app>HelloWorld</app>
            <device>hwTest</device>
            <templated>true</templated>
            <inputs>
                <number>
                    {%- if steps | length > 0 -%}
                        {%- set x = outputFrom(steps, -1) -%}
                    {%- endif -%}

                    {%- if x is not none and x is defined -%}
                        {{x}}
                    {%- else -%}
                        1
                    {%- endif -%}
                </number>
            </inputs>
            <next step="start">
                <flag action="regMatch">
                    <args>
                        <regex>1|2|3|4</regex>
                    </args>
                    <filters>
                    </filters>
                </flag>
            </next>
            <next step="1">
                <flag action="regMatch">
                    <args>
                        <regex>5</regex>
                    </args>
                    <filters>
                    </filters>
                </flag>
            </next>
            <error step="1"></error>
        </step>
        <step id="1">
            <action>repeatBackToMe</action>
            <app>HelloWorld</app>
            <device>hwTest</device>
            <templated>true</templated>
            <inputs>
                <call>{{outputFrom(steps, -1)}}</call>
            </inputs>
            <error step="1"></error>
        </step>
    </steps>
</workflow>

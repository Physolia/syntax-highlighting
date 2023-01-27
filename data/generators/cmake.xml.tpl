<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE language
[
  <!-- NOTE See https://cmake.org/cmake/help/latest/manual/cmake-language.7.html#variable-references -->
  <!ENTITY var_ref_re "[/\.\+\-_0-9A-Za-z]+">
  <!-- NOTE See `cmGeneratorExpression::IsValidTargetName` -->
  <!ENTITY tgt_name_re "[A-Za-z0-9_\.\+\-]+">
]>
<!--
    This file is part of KDE's kate project.

    SPDX-FileCopyrightText: 2004 Alexander Neundorf <neundorf@kde.org>
    SPDX-FileCopyrightText: 2005 Dominik Haumann <dhdev@gmx.de>
    SPDX-FileCopyrightText: 2007, 2008, 2013, 2014 Matthew Woehlke <mw_triad@users.sourceforge.net>
    SPDX-FileCopyrightText: 2013-2015, 2017-2020 Alex Turbov <i.zaufi@gmail.com>

    SPDX-License-Identifier: LGPL-2.0-or-later
 -->

<!-- ***** THIS FILE WAS GENERATED BY A SCRIPT - DO NOT EDIT *****
  cd data/generators
  # increase version of cmake.xml.tpl then
  ./generate-cmake-syntax.py cmake.yaml > ../syntax/cmake.xml
-->

<language
    name="CMake"
    version="<!--{version}-->"
    kateversion="5.0"
    section="Other"
    extensions="CMakeLists.txt;*.cmake;*.cmake.in"
    style="CMake"
    mimetype="text/x-cmake"
    author="Alex Turbov (i.zaufi@gmail.com)"
    license="LGPLv2+"
  >
  <highlighting>

    <list name="commands">
    <!--[- for command in commands ]-->
        <item><!--{command.name}--></item>
    <!--[- endfor ]-->
    </list>

    <!--[- macro render_command_arg_lists(commands) ]-->
    <!--[- for command in commands -]-->
      <!--[- if command.named_args and command.named_args.kw ]-->
    <list name="<!--{command.name}-->_nargs">
        <!--[- for arg in command.named_args.kw ]-->
      <item><!--{arg}--></item>
        <!--[- endfor ]-->
    </list>
      <!--[- endif ]-->
      <!--[- if command.special_args and command.special_args.kw ]-->
    <list name="<!--{command.name}-->_sargs">
        <!--[- for arg in command.special_args.kw ]-->
      <item><!--{arg}--></item>
        <!--[- endfor ]-->
    </list>
      <!--[- endif ]-->
    <!--[- endfor ]-->
    <!--[- endmacro ]-->
    <!--{- render_command_arg_lists(commands) }-->
    <!--{- render_command_arg_lists(standard_module_commands) }-->

    <list name="variables">
    <!--[- for var in variables.kw ]-->
      <item><!--{var}--></item>
    <!--[- endfor ]-->
    </list>

    <list name="deprecated-or-internal-variables">
    <!--[- for var in deprecated_or_internal_variables.kw ]-->
      <item><!--{var}--></item>
    <!--[- endfor ]-->
    </list>

    <list name="environment-variables">
    <!--[- for var in environment_variables.kw ]-->
      <item><!--{var}--></item>
    <!--[- endfor ]-->
    </list>

    <!--[- for kind in properties.kinds ]-->
    <list name="<!--{ kind|replace('_', '-') }-->">
      <!--[- for prop in properties[kind].kw ]-->
      <item><!--{prop}--></item>
      <!--[- endfor ]-->
    </list>
    <!--[- endfor ]-->

    <list name="generator-expressions">
      <!--[- for expr in generator_expressions ]-->
      <item><!--{ expr }--></item>
      <!--[- endfor ]-->
    </list>

    <list name="standard-modules">
      <!--[- for module in modules.utility ]-->
      <item><!--{ module }--></item>
      <!--[- endfor ]-->
    </list>

    <list name="standard-finder-modules">
      <!--[- for module in modules.finder ]-->
      <item><!--{ module | replace('Find', '') }--></item>
      <!--[- endfor ]-->
    </list>

    <list name="deprecated-modules">
      <!--[- for module in modules.deprecated ]-->
      <item><!--{ module }--></item>
      <!--[- endfor ]-->
    </list>

    <!-- Source/cmStringAlgorithms.cxx: bool cmIsOff(cm::string_view val) -->
    <list name="true_special_arg">
      <item>TRUE</item>
      <item>ON</item>
      <item>YES</item>
      <item>Y</item>
      <item>0</item>
    </list>

    <!-- Source/cmStringAlgorithms.cxx: bool cmIsOff(cm::string_view val) -->
    <list name="false_special_arg">
      <item>FALSE</item>
      <item>OFF</item>
      <item>NO</item>
      <item>IGNORE</item>
      <item>N</item>
      <item>0</item>
    </list>

    <contexts>

      <context attribute="Normal Text" lineEndContext="#stay" name="Normal Text">
        <DetectSpaces/>
        <!--[ for command in commands -]-->
        <WordDetect String="<!--{command.name}-->" insensitive="true" attribute="<!--{command.attribute}-->" context="<!--{command.name}-->_ctx"<!--[ if command.start_region ]--> beginRegion="<!--{command.start_region}-->"<!--[ endif -]--> <!--[- if command.end_region ]--> endRegion="<!--{command.end_region}-->"<!--[ endif ]--> />
        <!--[ endfor -]-->
        <!--[ for command in standard_module_commands -]-->
        <WordDetect String="<!--{command.name}-->" insensitive="true" attribute="CMake Provided Function/Macro" context="<!--{command.name}-->_ctx" />
        <!--[ endfor -]-->
        <DetectChar attribute="Comment" context="Match Comments and Docs" char="#" lookAhead="true" />
        <DetectIdentifier attribute="User Function/Macro" context="User Function" />
        <RegExpr attribute="@Variable Substitution" context="@VarSubst" String="@&var_ref_re;@" lookAhead="true" />
        <IncludeRules context="LineError" />
      </context>
      <!--[- macro render_command_parsers(commands) ]-->
      <!--[ for command in commands -]-->
      <context attribute="Normal Text" lineEndContext="#stay" name="<!--{command.name}-->_ctx">
        <DetectChar attribute="Normal Text" context="<!--{command.name}-->_ctx_op<!--{'_tgt_first' if command.first_arg_is_target else '_tgts_first' if command.first_args_are_targets else ''}-->" char="(" />
        <DetectChar attribute="Normal Text" context="#pop" char=")" />
      </context>
        <!--[- if command.first_arg_is_target ]-->
      <context attribute="Normal Text" lineEndContext="#stay" name="<!--{command.name}-->_ctx_op_tgt_first">
        <DetectSpaces />
        <RegExpr attribute="Aliased Targets" context="<!--{command.name}-->_ctx_op" String="&tgt_name_re;::&tgt_name_re;(?:\:\:&tgt_name_re;)*" />
        <RegExpr attribute="Targets" context="<!--{command.name}-->_ctx_op" String="&tgt_name_re;" />
        <IncludeRules context="User Function Opened" />
        <IncludeRules context="LineError" />
      </context>
        <!--[- endif ]-->
        <!--[- if command.first_args_are_targets ]-->
      <context attribute="Normal Text" lineEndContext="#stay" name="<!--{command.name}-->_ctx_op_tgts_first">
        <DetectSpaces />
        <!--[- if command.named_args and command.named_args.kw ]-->
          <!-- NOTE Handle the only case in CMake nowadays:
              1. `set_target_properties` have a named keyword (`PROPERTIES`) after targets list
          -->
        <keyword context="<!--{command.name}-->_ctx_op" String="<!--{command.name}-->_nargs" lookAhead="true" />
          <!--[- endif ]-->
        <IncludeRules context="Detect Aliased Targets" />
        <IncludeRules context="Detect Targets" />
        <IncludeRules context="User Function Opened" />
        <IncludeRules context="LineError" />
      </context>
        <!--[- endif ]-->
        <!--[- if not command.first_args_are_targets or (command.named_args and command.named_args.kw) ]-->
      <context attribute="Normal Text" lineEndContext="#stay" name="<!--{command.name}-->_ctx_op">
        <DetectSpaces />
        <!--[- if command.nested_parentheses ]-->
        <DetectChar attribute="Normal Text" context="<!--{command.name}-->_ctx_op_nested" char="(" />
        <!--[- endif ]-->
        <DetectChar attribute="Normal Text" context="#pop" char=")" lookAhead="true" />
        <!--[- if command.named_args and command.named_args.kw ]-->
          <!--[- if command.has_target_name_after_kw ]-->
        <WordDetect String="<!--{command.has_target_name_after_kw}-->" attribute="Named Args" context="Target Name" />
          <!--[- endif ]-->
          <!--[- if command.has_target_names_after_kw ]-->
        <WordDetect String="<!--{command.has_target_names_after_kw}-->" attribute="Named Args" context="<!--{command.name}-->_tgts" />
          <!--[- endif ]-->
        <keyword attribute="Named Args" context="#stay" String="<!--{command.name}-->_nargs" />
        <!--[- endif ]-->
        <!--[- if command.name == 'include' ]-->
        <keyword attribute="Standard Module" context="#stay" String="standard-modules" />
        <keyword attribute="Deprecated Module" context="#stay" String="deprecated-modules" />
        <!--[- endif ]-->
        <!--[- if command.name == 'find_package' ]-->
        <keyword attribute="Standard Module" context="#stay" String="standard-finder-modules" />
        <!--[- endif ]-->
        <!--[- if command.special_args and command.special_args.kw ]-->
        <keyword attribute="Special Args" context="#stay" String="<!--{command.name}-->_sargs" />
        <!--[- endif ]-->
        <!--[- if command.property_args and command.property_args.kw ]-->
          <!--[- for kind in command.property_args.kw ]-->
        <keyword attribute="Property" context="#stay" String="<!--{kind}-->" />
            <!--[- if properties[kind|replace('-', '_')].re ]-->
        <IncludeRules context="Detect More <!--{kind}-->" />
            <!--[- endif ]-->
          <!--[- endfor ]-->
        <!--[- endif ]-->
        <!--[- if command is not nulary ]-->
        <IncludeRules context="User Function Args" />
          <!--[- if command.name == 'cmake_policy' ]-->
        <!-- NOTE Handle CMP<NNN> as a special arg of `cmake_policy` command -->
        <RegExpr attribute="Special Args" context="#stay" String="\bCMP[0-9]+\b" />
          <!--[- endif ]-->
        <!--[- endif ]-->
      </context>
        <!--[- endif ]-->
        <!--[- if command.has_target_names_after_kw ]-->
      <context attribute="Normal Text" lineEndContext="#stay" name="<!--{command.name}-->_tgts">
        <DetectSpaces />
        <DetectChar attribute="Normal Text" context="#pop" char=")" lookAhead="true" />
        <keyword attribute="Named Args" context="#pop" String="<!--{command.name}-->_nargs" />
        <IncludeRules context="Detect Aliased Targets" />
        <IncludeRules context="Detect Targets" />
        <IncludeRules context="User Function Args" />
        <IncludeRules context="LineError" />
      </context>
        <!--[- endif ]-->
        <!--[- if command.nested_parentheses ]-->
      <context attribute="Normal Text" lineEndContext="#stay" name="<!--{command.name}-->_ctx_op_nested">
        <DetectSpaces />
        <DetectChar attribute="Normal Text" context="#pop" char=")" />
        <DetectChar attribute="Normal Text" context="<!--{command.name}-->_ctx_op_nested" char="(" />
        <!--[- if command.named_args and command.named_args.kw ]-->
        <keyword attribute="Named Args" context="#stay" String="<!--{command.name}-->_nargs" />
        <!--[- endif ]-->
        <!--[- if command.special_args and command.special_args.kw ]-->
        <keyword attribute="Special Args" context="#stay" String="<!--{command.name}-->_sargs" />
        <!--[- endif ]-->
        <!--[- if command.property_args and command.property_args.kw ]-->
          <!--[- for kind in command.property_args.kw ]-->
        <keyword attribute="Property" context="#stay" String="<!--{kind}-->" />
              <!--[- if properties[kind|replace('-', '_')].re ]-->
        <IncludeRules context="Detect More <!--{kind}-->" />
            <!--[- endif ]-->
          <!--[- endfor ]-->
        <!--[- endif ]-->
        <IncludeRules context="User Function Args" />
      </context>
        <!--[- endif ]-->
      <!--[ endfor -]-->
      <!--[- endmacro -]-->
      <!--{- render_command_parsers(commands) -}-->
      <!--{- render_command_parsers(standard_module_commands) -}-->
      <!--[ for kind in properties.kinds if properties[kind].re -]-->
      <context attribute="Normal Text" lineEndContext="#stay" name="Detect More <!--{ kind|replace('_', '-') }-->">
        <RegExpr attribute="Property" context="#stay" String="<!--{properties[kind].re}-->" />
      </context><!--{ '\n' }-->
      <!--[ endfor -]-->

      <context attribute="User Function/Macro" lineEndContext="#stay" name="User Function">
        <DetectChar attribute="Normal Text" context="User Function Opened" char="(" />
        <DetectChar attribute="Normal Text" context="#pop" char=")" />
      </context>

      <context attribute="Normal Text" lineEndContext="#stay" name="User Function Opened">
        <DetectChar attribute="Normal Text" context="#pop" char=")" lookAhead="true" />
        <IncludeRules context="User Function Args" />
      </context>

      <context attribute="Normal Text" lineEndContext="#stay" name="Detect Builtin Variables">
        <RegExpr attribute="Internal Name" context="#stay" String="\b_&var_ref_re;\b" />
        <keyword attribute="CMake Internal Variable" context="#stay" String="deprecated-or-internal-variables" insensitive="false" />
        <keyword attribute="Builtin Variable" context="#stay" String="variables" insensitive="false" />
        <IncludeRules context="Detect More Builtin Variables" />
      </context>

      <context attribute="Normal Text" lineEndContext="#stay" name="Detect More Builtin Variables">
        <!--[- if deprecated_or_internal_variables.re ]-->
        <RegExpr attribute="CMake Internal Variable" context="#stay" String="<!--{deprecated_or_internal_variables.re}-->" />
        <!--[- endif ]-->
        <!--[- if variables.re ]-->
        <RegExpr attribute="Builtin Variable" context="#stay" String="<!--{variables.re}-->" />
        <!--[- endif ]-->
      </context>

      <context attribute="Normal Text" lineEndContext="#stay" name="Detect Variable Substitutions">
        <RegExpr attribute="Cache Variable Substitution" context="#stay" String="\$CACHE\{\s*[\w-]+\s*\}" />
        <RegExpr attribute="Environment Variable Substitution" context="EnvVarSubst" String="\$?ENV\{" />
        <Detect2Chars attribute="Variable Substitution" context="VarSubst" char="$" char1="{" />
        <RegExpr attribute="@Variable Substitution" context="@VarSubst" String="@&var_ref_re;@" lookAhead="true" />
      </context>

      <context attribute="Environment Variable Substitution" lineEndContext="#pop" name="EnvVarSubst">
        <DetectChar attribute="Environment Variable Substitution" context="#pop" char="}" />
        <keyword attribute="Standard Environment Variable" context="#stay" String="environment-variables" insensitive="false" />
        <!--[- if environment_variables.re ]-->
        <RegExpr attribute="Standard Environment Variable" context="#stay" String="<!--{environment_variables.re}-->" />
        <!--[- endif ]-->
        <DetectIdentifier />
        <IncludeRules context="Detect Variable Substitutions" />
      </context>

      <context attribute="Variable Substitution" lineEndContext="#pop" name="VarSubst">
        <DetectChar attribute="Variable Substitution" context="#pop" char="}" />
        <IncludeRules context="Detect Builtin Variables" />
        <DetectIdentifier />
        <IncludeRules context="Detect Variable Substitutions" />
      </context>

      <context attribute="@Variable Substitution" lineEndContext="#pop" name="@VarSubst">
        <DetectChar attribute="@Variable Substitution" context="VarSubst@" char="@" />
      </context>

      <context attribute="@Variable Substitution" lineEndContext="#pop#pop" name="VarSubst@">
        <DetectChar attribute="@Variable Substitution" context="#pop#pop" char="@" />
        <IncludeRules context="Detect Builtin Variables" />
        <DetectIdentifier />
      </context>

      <context attribute="Normal Text" lineEndContext="#stay" name="Target Name">
        <DetectSpaces />
        <RegExpr attribute="Aliased Targets" context="#pop" String="&tgt_name_re;::&tgt_name_re;(?:\:\:&tgt_name_re;)*" />
        <IncludeRules context="Detect Targets" />
        <IncludeRules context="User Function Opened" />
        <IncludeRules context="LineError" />
      </context>

      <context attribute="Normal Text" lineEndContext="#stay" name="Detect Targets">
        <RegExpr attribute="Targets" context="#stay" String="&tgt_name_re;" />
      </context>

      <context attribute="Normal Text" lineEndContext="#stay" name="LineError">
        <RegExpr attribute="Error" context="#stay" String=".*" />
      </context>

      <context attribute="Normal Text" lineEndContext="#stay" name="User Function Args">
        <Detect2Chars attribute="Normal Text" context="#stay" char="\" char1="(" />
        <Detect2Chars attribute="Normal Text" context="#stay" char="\" char1=")" />
        <Detect2Chars attribute="Escapes" context="#stay" char="\" char1="&quot;" />
        <Detect2Chars attribute="Escapes" context="#stay" char="\" char1="$" />
        <Detect2Chars attribute="Escapes" context="#stay" char="\" char1="n" />
        <Detect2Chars attribute="Escapes" context="#stay" char="\" char1="\" />
        <DetectChar attribute="Strings" context="String" char="&quot;" />
        <RegExpr attribute="Strings" context="Bracketed String" String="\[(=*)\[" beginRegion="BracketedString" />
        <DetectChar attribute="Comment" context="Match Comments" char="#" lookAhead="true" />
        <IncludeRules context="Detect Builtin Variables" />
        <IncludeRules context="Detect Variable Substitutions" />
        <IncludeRules context="Detect Special Values" />
        <IncludeRules context="Detect Aliased Targets" />
        <IncludeRules context="Detect Generator Expressions" />
        <DetectIdentifier />
      </context>

      <context attribute="Normal Text" lineEndContext="#stay" name="Detect Special Values">
        <RegExpr attribute="Version Arg" context="#stay" String="\b[0-9]++(.[0-9]++)+\b" />
        <keyword attribute="True Special Arg" context="#stay" String="true_special_arg" insensitive="true" />
        <keyword attribute="False Special Arg" context="#stay" String="false_special_arg" insensitive="true" />
        <RegExpr attribute="False Special Arg" context="#stay" String="\b(?:&var_ref_re;-)?NOTFOUND\b" />
        <RegExpr attribute="Special Args" context="#stay" String="\bCMP[0-9][0-9][0-9][0-9]\b" />
      </context>

      <context attribute="Normal Text" lineEndContext="#stay" name="Detect Aliased Targets">
        <RegExpr attribute="Aliased Targets" context="#stay" String="&tgt_name_re;::&tgt_name_re;(?:\:\:&tgt_name_re;)*" />
      </context>

      <context attribute="Comment" lineEndContext="#pop" name="Match Comments">
        <DetectSpaces />
        <RegExpr attribute="Comment" context="#pop!Bracketed Comment" String="#\[(=*)\[" beginRegion="BracketedComment" />
        <DetectChar attribute="Comment" context="#pop!Comment" char="#" />
        <DetectIdentifier />
      </context>

      <context attribute="Comment" lineEndContext="#pop" name="Match Comments and Docs">
        <RegExpr attribute="Region Marker" context="#pop!RST Documentation" String="^#\[(=*)\[\.rst:" column="0" beginRegion="RSTDocumentation" />
        <IncludeRules context="Match Comments" />
      </context>

      <context attribute="Comment" lineEndContext="#pop" name="Comment">
        <DetectSpaces />
        <LineContinue attribute="Comment" context="#pop" />
        <IncludeRules context="##Comments" />
        <DetectIdentifier />
      </context>

      <context attribute="Comment" lineEndContext="#stay" name="RST Documentation" dynamic="true">
        <RegExpr attribute="Region Marker" context="#pop" String="^#?\]%1\]" dynamic="true" column="0" endRegion="RSTDocumentation" />
        <IncludeRules context="##reStructuredText" />
      </context>

      <context attribute="Comment" lineEndContext="#stay" name="Bracketed Comment" dynamic="true">
        <LineContinue attribute="Comment" context="#stay" />
        <DetectSpaces />
        <StringDetect attribute="Comment" context="#pop" String="]%1]" dynamic="true" endRegion="BracketedComment" />
        <IncludeRules context="##Comments" />
      </context>

      <context attribute="Strings" lineEndContext="#stay" name="String">
        <DetectSpaces />
        <DetectIdentifier />
        <RegExpr attribute="Strings" context="#pop" String="&quot;(?=[ );]|$)" />
        <Detect2Chars attribute="Escapes" context="#stay" char="\" char1="&quot;" />
        <Detect2Chars attribute="Escapes" context="#stay" char="\" char1="$" />
        <Detect2Chars attribute="Escapes" context="#stay" char="\" char1="n" />
        <Detect2Chars attribute="Escapes" context="#stay" char="\" char1="r" />
        <Detect2Chars attribute="Escapes" context="#stay" char="\" char1="t" />
        <Detect2Chars attribute="Escapes" context="#stay" char="\" char1="\" />
        <IncludeRules context="Detect Variable Substitutions" />
        <IncludeRules context="Detect Generator Expressions" />
      </context>

      <context attribute="Strings" lineEndContext="#stay" name="Bracketed String" dynamic="true">
        <StringDetect attribute="Strings" context="#pop" String="]%1]" dynamic="true" endRegion="BracketedString" />
      </context>

      <context attribute="Normal Text" lineEndContext="#stay" name="Detect Generator Expressions">
        <Detect2Chars attribute="Generator Expression" context="Generator Expression" char="$" char1="&lt;" />
      </context>

      <context attribute="Generator Expression" lineEndContext="#stay" name="Generator Expression">
        <IncludeRules context="Detect Generator Expressions" />
        <DetectChar attribute="Comment" context="Comment" char="#" />
        <DetectChar attribute="Generator Expression" context="#pop" char="&gt;" />
        <keyword attribute="Generator Expression Keyword" context="#stay" String="generator-expressions" insensitive="false" />
        <IncludeRules context="Detect Aliased Targets" />
        <IncludeRules context="Detect Variable Substitutions" />
        <DetectIdentifier />
      </context>

    </contexts>

    <itemDatas>
      <itemData name="Normal Text" defStyleNum="dsNormal" spellChecking="false" />
      <itemData name="Comment" defStyleNum="dsComment" spellChecking="true" />
      <itemData name="Command" defStyleNum="dsKeyword" spellChecking="false" />
      <itemData name="Control Flow" defStyleNum="dsControlFlow" spellChecking="false" />
      <itemData name="CMake Provided Function/Macro" defStyleNum="dsFunction" bold="true" spellChecking="false" />
      <itemData name="User Function/Macro"  defStyleNum="dsFunction" spellChecking="false" />
      <itemData name="Property" defStyleNum="dsOthers" spellChecking="false" />
      <itemData name="Targets" defStyleNum="dsBaseN" spellChecking="false" />
      <itemData name="Aliased Targets" defStyleNum="dsBaseN" spellChecking="false" />
      <itemData name="Named Args" defStyleNum="dsOthers" spellChecking="false" />
      <itemData name="Special Args" defStyleNum="dsOthers" spellChecking="false" />
      <itemData name="True Special Arg" defStyleNum="dsOthers" color="#30a030" selColor="#30a030" spellChecking="false" />
      <itemData name="False Special Arg" defStyleNum="dsOthers" color="#e05050" selColor="#e05050" spellChecking="false" />
      <itemData name="Version Arg" defStyleNum="dsDataType" spellChecking="false" />
      <itemData name="Strings" defStyleNum="dsString" spellChecking="true" />
      <itemData name="Escapes" defStyleNum="dsSpecialChar" spellChecking="false" />
      <itemData name="Builtin Variable" defStyleNum="dsDecVal" color="#c09050" selColor="#c09050" spellChecking="false" />
      <itemData name="CMake Internal Variable" defStyleNum="dsVariable" spellChecking="false" />
      <itemData name="Internal Name" defStyleNum="dsVariable" spellChecking="false" />
      <itemData name="Variable Substitution" defStyleNum="dsDecVal" spellChecking="false" />
      <itemData name="@Variable Substitution" defStyleNum="dsBaseN" spellChecking="false" />
      <itemData name="Cache Variable Substitution" defStyleNum="dsFloat" spellChecking="false" />
      <itemData name="Environment Variable Substitution" defStyleNum="dsFloat" spellChecking="false" />
      <itemData name="Standard Environment Variable" defStyleNum="dsFloat" spellChecking="false" />
      <itemData name="Generator Expression Keyword" defStyleNum="dsKeyword" color="#b84040" selColor="#b84040" spellChecking="false" />
      <itemData name="Generator Expression" defStyleNum="dsOthers" color="#b86050" selColor="#b86050" spellChecking="false" />
      <itemData name="Standard Module" defStyleNum="dsImport" spellChecking="false" />
      <itemData name="Deprecated Module" defStyleNum="dsImport" spellChecking="false" />
      <itemData name="Region Marker" defStyleNum="dsRegionMarker" spellChecking="false" />
      <itemData name="Error" defStyleNum="dsError" spellChecking="false" />
    </itemDatas>

  </highlighting>

  <general>
    <comments>
      <comment name="singleLine" start="#" position="afterwhitespace" />
      <comment name="multiLine" start="#[[" end="]]" region="BracketedComment" />
    </comments>
    <keywords casesensitive="1" weakDeliminator="." />
  </general>
</language>

<!-- kate: replace-tabs on; indent-width 2; tab-width 2; -->

{
  Author: Raymond van Venetië and Merlijn Wajer
  Project: Simba (https://github.com/MerlijnWajer/Simba)
  License: GNU General Public License (https://www.gnu.org/licenses/gpl-3.0)
}
{$mode ObjFPC}{$H+}

{$IFOPT D+}
  {$DEFINE SIMBA_HAS_DEBUGINFO}
{$ENDIF}

// Set in project options > custom options "-CfSSE"
//{$IF Defined(CPU386)}
//  {$FPUTYPE SSE3}
//{$ELSEIF Defined(CPUX86_64)}
//  {$FPUTYPE SSE64}
//{$ENDIF}

{$MACRO ON}

{$MODESWITCH ADVANCEDRECORDS}
{$MODESWITCH TYPEHELPERS}
{$MODESWITCH ARRAYOPERATORS}
{$MODESWITCH NESTEDPROCVARS}

{$DEFINE SIMBA_MAJOR   := 2000} // this should be 980 even if SimbaVersion is 981, etc
{$DEFINE SIMBA_VERSION := 2000}

{$DEFINE SIMBA_GITHUB_URL   := 'https://github.com/Villavu/Simba'}
{$DEFINE SIMBA_BUGS_URL     := 'https://github.com/Villavu/Simba/issues'}
{$DEFINE SIMBA_DOCS_URL     := 'https://villavu.github.io/Simba/'}
{$DEFINE SIMBA_PACKAGES_URL := 'https://raw.githubusercontent.com/Villavu/Simba-Package-List/main/list'}

{$IFDEF DARWIN}
  {$DEFINE SIMBA_ANALYTICS_URL := 'https://olly.best/simba.php'}
{$ELSE}
  {$DEFINE SIMBA_ANALYTICS_URL := 'http://olly.best/simba.php'}
{$ENDIF}

// GITHUB_XXX env variables are available when building in github actions
{$DEFINE SIMBA_COMMIT     := {$INCLUDE %GITHUB_SHORT_SHA%}}
{$DEFINE SIMBA_COMMIT_URL := {$INCLUDE %GITHUB_SERVER_URL%} + '/' + {$INCLUDE %GITHUB_REPOSITORY%} + '/commit/' + {$INCLUDE %GITHUB_SHORT_SHA%}}

// use mORMot memory manager. This should be better than default FPC for our uses.
// This will only be used on x86_64 Windows & Linux.
// nevermind - is causing issues
{.$DEFINE SIMBA_CUSTOM_MM}

{$IFDEF Lape_CDECL}
  {$DEFINE LAPE_WRAPPER_CALLING_CONV := cdecl;}
{$ENDIF}

// bitshifts for color channels
{$DEFINE A_BIT := 24}
{$DEFINE B_BIT := 16}
{$DEFINE G_BIT := 8}
{$DEFINE R_BIT := 0}

// masks for color channels
{$DEFINE B_MASK := $FF0000}
{$DEFINE G_MASK := $00FF00}
{$DEFINE R_MASK := $0000FF}

// cpu string
{$IF DEFINED(CPU32)}
  {$DEFINE CPU := 'CPU32'}
{$ELSEIF DEFINED(CPUAARCH64)}
  {$DEFINE CPU := 'CPUAARCH64'}
{$ELSEIF DEFINED(CPU64)}
  {$DEFINE CPU := 'CPU64'}
{$ENDIF}

// os string
{$IF DEFINED(WINDOWS)}
  {$DEFINE OS := 'WINDOWS'}
{$ELSEIF DEFINED(DARWIN)}
  {$DEFINE OS := 'DARWIN'}
{$ELSEIF DEFINED(LINUX)}
  {$DEFINE OS := 'LINUX'}
{$ENDIF}


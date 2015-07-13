# Ktos.Build.GitVersion

Hello.

This nuget updates your AssemblyInfo.cs with data from git repository based on Git Flow model (http://nvie.com/posts/a-successful-git-branching-model/), allowing you to create Semantic Versioning (http://semver.org/). It is basically a modification of GitVersion (https://github.com/ParticularLabs/GitVersion). Main differences are that using MSBuildCommunityTasks the AssemblyInfo.template.cs file is being changed with some variables being changed to proper version info, instead of creating completely new AssemblyInfo.cs. 

Reasons are: 
* I don't like GitVersion full versioning (like 1.2.3+4.Branch.master.Sha.12345678901234567890), so I can use here my own versioning scheme (like 1.2.3+4.master.1234567) (without "branch", "sha" and with short SHA hash);
* Automatically generated assemblies from GitVersion were not compatible with NETMF.

Project uses GitVersion task from GitVersion (and modified Target files from it) and MSBuildCommunityTasks scripts in it's installer (and as a dependency, as it requires TemplateFile task).

## Installation

When installed to solution (preferrably) or project, your project is not being automatically connected to neither Ktos.Build.GitVersion nor MSBuildTasks. You need to:

* Update project files with references to Ktos.Build.GitVersion and MSBuildCommunityTasks:

<PropertyGroup>
  <MSBuildCommunityTasksPath>$(SolutionDir)\.build</MSBuildCommunityTasksPath>
</PropertyGroup>
<Import Project="$(MSBuildCommunityTasksPath)\MSBuild.Community.Tasks.Targets" />
<Import Project="$(MSBuildCommunityTasksPath)\Ktos.Build.GitVersion.Targets" />

* Update nuget-added AssemblyInfo.template.cs in csproj to action "none" (not "Compile", so it will be in project, but not compiled);
* Update AssemblyInfo.template.cs with your proper GUID and proper information inside (probably copied from existing AssemblyInfo.cs);

You should also remove AssemblyInfo.cs from your version control system repository (and probably ignore, as it will be auto-generated).

Regards,
Ktos
param($installPath, $toolsPath, $package, $project)

Import-Module (Join-Path $toolsPath "MSBuild.psm1")

function Copy-MSBuildTasks($project) {
	$solutionDir = Get-SolutionDir
	$tasksToolsPath = (Join-Path $solutionDir ".build")

	if(!(Test-Path $tasksToolsPath)) {
		mkdir $tasksToolsPath | Out-Null
	}

	Write-Host "Copying Ktos.Build.GitVersion files to $tasksToolsPath"	
	Copy-Item "$toolsPath\Ktos.Build.GitVersion.targets" $tasksToolsPath -Force | Out-Null	
	
	return "$tasksToolsPath"
}

function Add-Solution-Folder($buildPath) {
	# Get the open solution.
	$solution = Get-Interface $dte.Solution ([EnvDTE80.Solution2])

	# Create the solution folder.
	$buildFolder = $solution.Projects | Where {$_.ProjectName -eq ".build"}
	if (!$buildFolder) {
		$buildFolder = $solution.AddSolutionFolder(".build")
	}

	
	# Add files to solution folder
	$projectItems = Get-Interface $buildFolder.ProjectItems ([EnvDTE.ProjectItems])

	$targetsPath = [IO.Path]::GetFullPath( (Join-Path $buildPath "Ktos.Build.GitVersion.targets") )
	$projectItems.AddFromFile($targetsPath)	
}


function Main 
{
	$taskPath = Copy-MSBuildTasks $project
	Add-Solution-Folder $taskPath
}

Main

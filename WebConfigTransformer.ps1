	Param(
        
        [String] $solution_dir ="D:\User\Source\Repos\Accounting" , 
        [String] $project_dir ="D:\User\Source\Repos\Accounting\Accounting",
        [String] $output_path = "D:\User\BuildOutput\Accounting"
        )
       
    $webconfig = $project_dir+"\web.config"

    Add-Type -LiteralPath "$solution_dir\packages\MSBuild.Microsoft.VisualStudio.Web.targets.14.0.0.3\tools\VSToolsPath\Web\Microsoft.Web.XmlTransform.dll"

    
    New-Item -ItemType directory -Path "$output_path\TransformedConfigs" -Force

	ls $project_dir -Filter "Web.*.config" -Exclude "web.config" ,"web.release.config", "web.debug.config" -Recurse |% {


         $xmldoc = New-Object Microsoft.Web.XmlTransform.XmlTransformableDocument;
    	 $xmldoc.PreserveWhitespace = $true
    	 $xmldoc.Load($webconfig);
    

         Write-Output "Transforming configuration file: " $_.Fullname

    	 $transform = New-Object Microsoft.Web.XmlTransform.XmlTransformation($_.Fullname);
         $transform.Apply($xmldoc);
    	 $xmldoc.Save("$output_path\TransformedConfigs\"+$_.Name)
    }
$Win32ShowWindowAsync = Add-Type -MemberDefinition @'

[DllImport("user32.dll")]

public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);

'@ -Name "Win32ShowWindowAsync" -Namespace Win32Functions -PassThru

 

Start-Process 'C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe'

Start-Sleep -s 150

$Win32ShowWindowAsync::ShowWindowAsync((Get-Process -Name 'thunderbird').MainWindowHandle, 7) | Out-Null

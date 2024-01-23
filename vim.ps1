
Copy-Item .vimrc ~/.vimrc


Copy-Item .vsvimrc ~/.vsvimrc


# add-content will automatically create newlines
Add-Content ~/.vsvimrc (Get-Content .vimrc)

# Get-Content .vimrc >> ~/.vsvimrc


# Write-Output " " >> ~/.vsvimrc



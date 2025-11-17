settings
{
	priority=1
	exclude.where = !process.is_explorer
	showdelay = 200
	// Options to allow modification of system items
	modify.remove.duplicate=1
	tip.enabled=true
}

import 'imports/theme.nss'
import 'imports/images.nss'

import 'imports/modify.nss'

// modify items
remove (find = '"Add to Favorites"')
remove (find = '"Edit with Photos"')
remove (find = '"Edit with Paint"')
remove (find = '"Scan with Microsoft Defender"')
remove (find = '"Open with Visual Studio"')
remove (find = '"Create with Designer"')
remove (find = '"Resize with Image Resizer"')
remove (find = '*VLC*')
remove (find = '*Vim*')

menu(mode="multiple" title="Pin/Unpin" image=icon.pin)
{
}

menu(mode="multiple" title=title.more_options image=icon.more_options)
{
}

import 'imports/terminal.nss'
import 'imports/file-manage.nss'
import 'imports/develop.nss'
import 'imports/goto.nss'
import 'imports/taskbar.nss'

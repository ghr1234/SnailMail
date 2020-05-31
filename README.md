## Description ##

Snail Mail is an envelope addressing and printing application which interacts directly with the Address Book database in Mac OS X.

Snail Mail's primary function is to quickly address and print single or multiple envelopes based on entries in the Mac OS X Address Book database, but it also allows ad-hoc manual entry of addresses directly onto the envelope.

Batches of envelopes can be based on Address Book groups, or ad-hoc selections of addresses. Snail Mail can print USPS barcodes for more efficient mail handling. Snail Mail provides for different default text attributes (font, colour, etc) for different parts of the address.
Snail Mail also includes a Plugin for Mac OS X's Address Book application so that you can choose to print Snail Mail envelopes directly from the Address Book, and uses Mac OS X 'services' to print any selected text from any other application to an envelope quickly and easily.


If you are looking for a pre-built binary, try the [github download page](https://github.com/knowuh/SnailMail/downloads).

## Features: ##

* Print address with barcodes.
* Choose which fields show up in the address.
* Choose how the return address is formatted.


## History ##
Snail Mail was originally developed by Nik Sands, for the office of Mr David Lloyd, at a time when there were no other envelope printing applications available.

Nik's other software efforts can be found at <http://nixanz.com/>

## Credits ##

* Snail Mail Software written by Nik Sands
* NKDBarcode Barcode Library by Jeff LaMarche
* Application icon by Dave Hill
* Toolbar icons by Dave Hossack
* githubification by Noah Paessel

## License ##
Original Source Copyright &copy; 2011 Nik Sands
Original NKDBarcode sourcecode &copy; 2002 Jeff LaMarche and Naked Software.

As of Jan 4 2011 all of Snail Mail has been opened, and is distributed under the
[MIT license](http://www.opensource.org/licenses/mit-license.php).


## Known issues ##

For a current list of issues, or to report a new issue, see the [github issue page](https://github.com/knowuh/SnailMail/issues)

Open Issues As of Version 1.91:

## Todo List ##

Look into removing use of private methods

Address Book has been replaced by Contacts so all Address Book APIs should be changed, if possible (but see previous point)

## Change Log ##

=======
### 1.91 ###

* Updated to use ARC
* Removed data-size warnings (replaced int with NSInteger)
* Replaced deprecated objects and methods

May, 2020

### 1.9 ###

* Compiles for 64-bit only. Compiles on Mojave (10.14) and Yosemite (10.10) and maybe others in-between.

May, 2020

###1.8###

* Records for companies will now match person name as well as company name when searching (as for records for people).
*  titlebar/toolbar.

###1.7###

*  in the "Search" field now searches Company, Job Title and Nickname (in addition to Name and Address).  These items can also be viewed in the person table instead of the Address, if desired.

###1.6###

*  envelope profiles correctly updates return address type (address book, manual, none).
*  a crash-on-launch bug introduced in version 1.5 for users who had no postal address in the Address Book card (or no Address Book "My Card").

###1.5###

*  preference to hide delivery country only if same as return address country (as has been available for return address in earlier versions).
*  preference to swap family name and given name, to suit broader cultural user base.
*  option to remove return address completely with a single step (no longer a two step process of selecting "Manual" return address, then manually deleting return address content).
*  start up, the search field has the keyboard focus, so that no pointing or clicking is required to beging typing a search term (this feature went missing several releases ago).

###1.4###

*  two printing bugs where printing failed in some circumstances (eg, after cancelling one print job, subsequent print jobs would fail).

###1.2###

*  "Manual" return address setting is now set on a per-envelope-profile basis.

###1.1###

*  preference to print an envelope for persons who don't have addresses that match the specified label (eg, "Home" or "Work"), when using the "Print Selected Envelopes" command for a specific label (Home/Work/etc) only.
*  the size of the download distribution.

###1.0###

*  Selected Envelopes command can now be restricted to printing only addresses with a particular label (eg, only "Home" addresses or only "Work" addresses).  The label to use is set in Preferences (per-envelope-profile).
*  in the Return Address pop-up are now sorted alphabetically, which is particularly useful when configured to include all records in the address book.
*  current envelope profile now correctly remembers the last used print settings (including printer) and these settings are correctly used when printing without a dialogue with the Print toolbar item.
*  online help.

###0.6.8###

*  a bug where in the unlikely case of an Address Book record having two identical addresses, and a third address which was different, the wrong return address could be placed on the envelope.

###0.6.7###

*  theoretical Intel Mac OS X compatibility (now distributed as a "universal" application that runs on both PowerPC and Intel versions of Mac OS X).  I don't have access to a Mac OS X Intel machine, so I'd be interested to hear from any users on the results of this.
* -introduced the registration toolbar item.  This was previously removed when Mac OS X 10.4 was released as the Address Book now handles envelope printing directly, and the number of new Snail Mail users dropped substantially.  However, the number of new users is on the rise again with many users opting to register.

###0.6.6###

*  preferences and settings that affect the look of an envelope are now set on a per-envelope-profile basis.  Eg, envelope background, field hiding, return address, can all be different for each different envelope profile.
*  PayPal integration.

###0.6.4###

*  longer prints rulers on individual envelope print outs if they are visible in the window at time of printing.

###0.6.3###

*  French localisation.
*  CHANGES for English or other locales.

###0.6.1###

*  now change correctly when the envelope profile is changed (ie, text attributes, field hiding, prefix/suffix and envelope background text/graphics, paper size and margins are all configured on a per-profile basis).
*  command names "Envelope Page Setup" to "Page Setup" and changed "Envelope Setup" to "Profile" in the UI to avoid confusion.
*  a problem with deleting the currently active profile.
*  problem with some preferences (eg, field hiding) being ignored in German localisation.

###0.6###

*  text and graphics can now be placed anywhere on the envelope, not just in the address text areas, simply by typing, copy/paste and drag/drop.
*  is now positioned at the bottom margin of the envelope, by default (with a preference to place it above the address where it used to be in previous versions).
* -instated the system "Services" provided by Snail Mail (missing in action since version 0.5).
*  preferences to hide the country of the delivery address is same as return address country now works correctly for printing multiple envelopes instead of following whatever the hiding behaviour was for the first envelope.
*  the user does not have permissions to install the Address Book plug-in globally, it now gets installed for the current user only.
*  the Address Book plug-in fails to install (both globally and user-only), an error dialogue is displayed.
*  the plug-in fails to launch the application, an error dialogue is displayed (plug-in can be updated by removing and re-installing using the command the application's "File" menu).
*  license toolbar item (for unregistered instances) has been removed.  Registration can still be managed using the command in the "Snail Mail" menu.
*  a bug which could prevent the "Text Attributes" and "Paste Address" items from appearing in the toolbar.
*  allows the standard user customisation of the toolbar.
*  clarified by changing "Addressee" to "Delivery Address" in user interface and documentation.


</body>
</html>

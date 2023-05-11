ß∂CREATE TABLE IF NOT EXISTS `#__jdocmanual_gfmindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jdoc_key` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `manual` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `heading` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_title` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '0',
  `created` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL,
  `html` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `language` (`jdoc_key`,`manual`,`language`),
  KEY `state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `#__jdocmanual_gfmindex` CHANGE `created` `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP; 
-- Populate the table in post-flight?

CREATE TABLE IF NOT EXISTS `#__jdocmanual_languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `index_language` int(11) NOT NULL DEFAULT '0',
  `page_language` int(11) NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO `#__jdocmanual_languages` (`id`, `code`, `title`, `index_language`, `page_language`, `lft`, `rgt`, `state`) VALUES
(1, 'en', 'English', 1, 1, 0, 0, 1),
(2, 'nl', 'Dutch', 1, 1, 0, 0, 1),
(3, 'fr', 'French', 1, 1, 0, 0, 1),
(4, 'de', 'German', 1, 1, 0, 0, 1),
(5, 'es', 'Spanish', 1, 1, 0, 0, 1),
(6, 'pt', 'Portuguese', 1, 1, 0, 0, 1),
(7, 'pt-br', 'Portuguese-Brazil', 1, 1, 0, 0, 1),
(8, 'ru', 'Russian', 1, 1, 0, 0, 1);

CREATE TABLE IF NOT EXISTS `#__jdocmanual_sources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manual` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `index_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mdmenu` text COLLATE utf8mb4_unicode_ci,
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO `#__jdocmanual_sources` (`id`, `manual`, `title`, `index_url`, `page_url`, `mdmenu`, `lft`, `rgt`, `state`) VALUES
(1, 'user', 'Joomla 4 User Manual', 'https://docs.joomla.org/J4.x:Joomla_4_User_Manual_Index', 'https://docs.joomla.org/', '### getting-started
- J4.x:Introduction_to_Joomla!
- J4.x:Joomla_Core_Features
- J4.x:Hosting_Setup
- J4.x:Installing_Joomla
- J4.x:Logging_in_to_Joomla
- J4.x:Articles_and_categories
- J4.x:Getting_Started:_Adding_an_Article
- J4.x:Getting_Started:_Adding_a_Category
- J4.x:Getting_Started:_Adding_a_Menu_Item
- J4.x:Getting_Started:_Adding_a_Module
- J4.x:Getting_Started:_Site_and_Administrator_templates
- Keyboard_Shortcuts

### articles
- J4.x:Create_and_Manage_Article_Categories
- J4.x:Adding_a_New_Article
- J4.x:Deleting_an_Article
- J4.x:Featured_Articles
- J4.x:How_to_Archive_an_Article
- J4.x:Article_Headings
- Adding_an_image_to_an_article
- J4.x:Article_Links
- J4.x:Adding_a_menu_link_in_an_article
- J4.x:Read_More_Links
- J4.x:Article_Lists
- J4.x:Article_Pagination
- J4.x:Article_Tables

### articles-access
- J4.x:Article_Check-out_and_Check-in
- J4.x:Article_Preview
- J4.x:Scheduling_the_publication_of_an_article
- J4.x:Restricting_access_to_an_Article
- Restricting_access_to_read_more

### articles-metadata
- Entering_search_engine_meta-data
- Using_The_Meta_Description
- Using_The_Title_Tag
- Using_Keywords

### banners
- J4.x:Banners
- Help4.x:Banners
- Help4.x:Banners:_Edit
- Help4.x:Banners:_Categories
- Help4.x:Banners:_Clients
- Help4.x:Banners:_New_or_Edit_Client
- Help4.x:Banners:_Tracks

### command-line-interface
- J4.x:Using_the_CLI
- J4.x:CLI_Database_Exporter_Importer
- J4.x:CLI_Update
- J4.x:Joomla_CLI_Installation

### configuration
- J4.x:System_Setup
- J4.x:Global_Configuration
- J4.x:Site_Offline
- How_do_I_use_Gmail_as_my_mail_server?
- How_to_debug_SMTP_mail_in_Joomla_4
- Preconfigured_htaccess
- Robots.txt_file
- Adding_www_to_a_url
- How_do_you_block_direct_hot_linking_to_image_files_using_htaccess?
- How_do_you_block_directory_scans_using_htaccess?
- What_are_the_recommended_file_and_directory_permissions?
- How_do_you_convert_an_htaccess.txt_file_into_a_.htaccess_file?
- How_do_you_password_protect_directories_using_htaccess?

### contacts
- Help4.x:Contacts
- Listing_a_user_on_a_contacts_page
- What_is_the_contact_creator?

### dashboards
- J4.x:Home_Dashboard
- J4.x:Content_Dashboard
- J4.x:Menu_Dashboard
- J4.x:Components_Dashboard
- J4.x:Users_Dashboard
- J4.x:System_Dashboard
- J4.x:Help

### editors
- Content_editors
- Entering_raw_HTML_in_editors
- Why_are_the_backgrounds_of_your_WYSIWYG_editor_fields_colored?
- Why_do_the_pop_ups_in_your_WYSIWYG_editor_not_work_or_show_gibberish?
- How_to_place_a_copy_of_an_Excel_worksheet_on_to_your_web_site_for_viewing_only

### extensions
- J4.x:System_Install
- Free_and_Commercial_extensions
- What_is_a_vulnerable_extension?
- Where_can_you_learn_about_vulnerable_extensions?
- How_do_you_choose_secure_extensions?
- Why_are_there_vulnerable_extensions?
- Why_isn\'t_un-publishing_a_vulnerable_extension_enough_to_protect_your_site?
- Installing_an_extension
- J4.x:Using_Bootstrap_Components_in_Joomla_4

### fields
- J4.x:Fields_and_Field_Groups
- J3.x:Adding_custom_fields/Multilingual_Sites
- J3.x:Adding_custom_fields/Overrides
- J3.x:Adding_custom_fields/Parameters_for_all_Custom_Fields
- J3.x:Adding_custom_fields/What_components_are_supporting_custom_fields
- J3.x:Adding_custom_fields/Calendar_Field
- J3.x:Adding_custom_fields/Checkboxes_Field
- J3.x:Adding_custom_fields/Color_Field
- J3.x:Adding_custom_fields/Editor_Field
- J3.x:Adding_custom_fields/Integer_Field
- J3.x:Adding_custom_fields/List_Field
- J3.x:Adding_custom_fields/List_of_Images_Field
- J3.x:Adding_custom_fields/Media_Field
- J3.x:Adding_custom_fields/Radio_Field
- J3.x:Adding_custom_fields/Sql_Field
- J3.x:Adding_custom_fields/Text_Field
- J3.x:Adding_custom_fields/Textarea_Field
- J3.x:Adding_custom_fields/Url_Field
- J3.x:Adding_custom_fields/User_Field
- J3.x:Adding_custom_fields/Usergroup_Field

### help
- Joomla_help_system
- What_are_help_screens?

### hosting
- J4.x:Optional_Technical_Requirements
- J4.x:Apache_PHP_Handler
- Moving_the_site_among_directories/sub-directories
- Multiple_Domains_and_Web_Sites_in_a_single_Joomla!_installation
- Nginx
- Should_PHP_run_as_a_CGI_script_or_as_an_Apache_module?
- What_is_the_difference_between_a_Sub-Domain,_Parked_Domain_and_an_Add-On_Domain?
- How_do_UNIX_file_permissions_work?
- How_do_Windows_file_permissions_work?
- How_do_phpSuExec_file_permissions_work?
- How_do_you_recursively_adjust_file_and_directory_permissions?
- How_do_you_restrict_directory_access_by_IP_address_using_htaccess?
- How_to_check_if_mod_rewrite_is_enabled_on_your_server
- Using_an_FTP_client_to_upload_files

### installation-variations
- How_to_build_your_free_Joomla_Website
- FreeBSD_Installation
- IBM_cloud_installation
- IIS
- Installing_Joomla!_using_BitNami_Joomla!_stack
- Installing_Joomla_on_Debian_Linux
- Installing_Joomla_on_a_Raspberry_Pi
- Installing_Joomla_on_a_local_web_server
- Installing_Joomla_on_a_rented_web_server
- Installing_Joomla_using_an_Auto_Installer

### languages
- J4.x:Setup_a_Multilingual_Site
- J4.x:Multilingual_Associations
- J4.x:Language_Overrides
- Debugging_a_translation

### media
- J4.x:Managing_Media
- J4.x:Media:_Upload_Delete_Rename
- J4.x:Media:_Image_Crop_Resize_Rotate
- J4.x:Media:_Options
- J4.x:Media:_Uploading_SVG_files

### menus
- J4.x:Adding_a_New_Menu
- J4.x:Menu_Items
- J4.x:Menu_Item_Types
- J4.x:Menu_Item_Order
- J4.x:Submenus
- J4.x:Menu_Positions
- Auto_redirect_guests_to_login
- J4.x:How_to_Create_a_Menu_Item_to_View_Archived_Articles
- J4.x:Adding_a_Custom_Administrator_Menu

### migration
- Why_Migrate
- Joomla_3.x_to_4.x_Step_by_Step_Migration
- J4.x:Updating_from_an_existing_version
- Migration_Step_by_Step_Self_Assessment
- Converting_an_existing_website_to_a_Joomla!_website
- J3.x:Update_fails_with_an_error_message
- J3.x:Updating_Joomla_(Install_Method)
- J3.x:Updating_Joomla_(Update_Method)
- Planning_Migration_-_Joomla_1.5_to_4
- Planning_for_Migration
- Planning_for_Mini-Migration_-_Joomla_3.10.x_to_4.x
- Potential_backward_compatibility_issues_in_Joomla_4
- Pre-Update_Check
- Template_Considerations_During_Migration

### modules
- J4.x:Site_Modules
- J4.x:Administrator_Modules
- J4.x:Module_Positions
- J4.x:Module_Display_by_Menu_Item
- How_do_you_put_a_module_inside_an_article?
- Enabling_the_Login_Form_module
- Changing_the_Login_Form_module_settings
- Customising_the_Login_Form_module
- Module_Class_Suffix
- Standard_Module_Chromes
- J4.x:How_to_Show_a_Calendar_Month_List_of_Archived_Articles_Using_a_Module
- How_do_you_create_a_custom_module?
- How_to_control_module_display_when_linking_to_an_article_with_no_menu_item
- How_do_you_add_a_PayPal_button?

### news-feeds
- Using_RSS_Feeds_To_Share_Content
- How_do_you_display_an_RSS_feed?

### performance
- Managing_404_Errors
- Validating_against_accessibility_standards

### plugins
- J3.x:Plugin_Joomla_Update_Notification

### privacy
- J4.x:Privacy_Setup
- J4.x:Privacy_Workflow
- Cookie_notification

### problems
- J4.x:Assorted_Issues
- J4.x:Unsupported_PHP_Version
- J4.x:FatalError
- J4.x:Fix_Database_Table_Structure_NOT_Up_to_Date_before_Update
- Get_locally_hosted_Joomla!_website_e-mail_functions_to_work
- Joomla_and_MySQL_8
- Please_first_make_a_selection_from_the_list
- Unable_to_connect_to_the_database
- Update_did_not_finish_successfully

### reference
- Joomla_Licenses
- What_has_the_copyright_of_Joomla!?
- What_license_is_Joomla!_released_under?
- What_are_web_standards?
- Where_are_the_web_pages?

### security
- What_is_the_Joomla!_Administrator\'s_Security_Checklist?
- Enabling_HTTPS_on_your_site
- Htaccess_examples_(security)
- Security_Checklist/Getting_Started
- Security_Checklist/Hosting_and_Server_Setup
- Security_Checklist/Where_can_you_learn_more_about_file_permissions?
- Security_Checklist/Testing_and_Development
- Security_Checklist/Joomla!_Setup
- Security_Checklist/Site_Administration
- Security_Checklist/Site_Recovery
- Security_Checklist/You_have_been_hacked_or_defaced
- Security_-_Before_you_go_live
- Security_FAQ
- Security_and_Performance_FAQs
- Security_filters_for_articles
- Securing_Joomla_extensions
- J4.x:Http_Header_Management

### seo
- What_is_Search_Engine_Optimisation
- Enabling_Search_Engine_Friendly_(SEF)_URLs
- Making_your_site_Search_Engine_Friendly
- Search_Engine_Friendly_URLs
- Using_A_Sitemap
- Semantic_HTML_Markup
- Linking_To_Other_Sites
- Important_SEO_Points_To_Remember
- Monitoring_SEO
- Common_problems_when_enabling_Search_Engine_Friendly_(SEF)_URLs

### smart-search
- Smart_Search_quickstart_guide
- Smart_Search_on_large_sites
- Customising_the_Smart_Search_results_page
- Setting_up_automatic_Smart_Search_indexing
- Smart_Search_Frequently_Asked_Questions
- Smart_Search_configuration_options
- Smart_Search_content_change_test_plan
- Creating_a_Smart_Search_plug-in

### system
- Cache
- Backup_Basics_for_a_Joomla!_Web_Site
- What_are_the_best_practices_for_site_backups?
- Copying_a_Joomla_website
- Copying_a_website_from_localhost_to_a_remote_host
- Database_Table_Prefix
- Monitoring_Server_Health
- Monitoring_Site_Speed
- One_click_updates_for_language_packs
- Purging_expired_cache_files
- Top_10_Stupidest_Administrator_Tricks
- Updating_PHP
- J4.x:Task_Scheduler
- Uploading_and_extracting_an_archive_file_with_CPanel
- Using_Caching_to_Speed_Up_Your_Code

### tags
- J4.x:How_To_Use_Content_Tags_in_Joomla

### templates
- J4.x:Template_Basics
- J4.x:Cassiopeia_Template_Customisation
- J4.x:Template_Overrides
- J4.x:Template_Layouts
- J4.x:Child_Templates
- J4.x:Favicons
- J4.x:Template_SVG_Logos
- J4.x:Cassiopeia_templateDetails.xml

### template-tips
- J4.x:Switching_Templates
- J4.x:Home_Page_in_Different_Style
- J4.x:Module_and_Menu_Styles
- J4.x:Joomla_Standard_Font_Awesome_Fonts

### test-installations
- Visual_Studio_Code_Primer
- Visual_Studio_Code
- J4.x:Developer:_Eclipse_PDT
- J4.x:Developer:_File_Structure
- J4.x:Developer:_Required_Software
- Setting_up_Apache,_PHP_and_MySQL_manually
- Verifying_permissions
- Web_page_diagnostic_tools
- XAMPP

### users
- J4.x:Access_Control
- J4.x:User_Registration
- J4.x:User_Profile
- J4.x:User_Password_Reset
- WebAuthn_Passwordless_Login
- J4.x:Multi-factor_Authentication
- Help4.x:Mass_Mail_Users
- Help4.x:Private_Messages
- How_do_you_recover_or_reset_your_admin_password?
- J4.x:Guest_Access
- Changing_user_groups
- J4.x:Login_and_Logout_Redirects
- Why_can\'t_a_user_see_anything_on_the_backend?
- J4.x:User_Actions_Log

### workflows
- J4.x:Workflow
- J4.x:Workflow/Scenarios', 1, 2, 1),
(2, 'help', 'Joomla 4 Help Screens', 'https://docs.joomla.org/J4.x:Joomla_4_Help_Screens', 'https://docs.joomla.org/', '### help-screens 
- Help4.x:Start_Here

### admin-modules 
- Help4.x:Admin_Modules:_Action_Logs_-_Latest
- Help4.x:Admin_Modules:_Administrator_Dashboard_Menu
- Help4.x:Admin_Modules:_Administrator_Menu
- Help4.x:Admin_Modules:_Articles_-_Latest
- Help4.x:Admin_Modules:_Custom
- Help4.x:Admin_Modules:_Feed_Display
- Help4.x:Admin_Modules:_Frontend_Link
- Help4.x:Admin_Modules:_Tours_Menu
- Help4.x:Admin_Modules:_Joomla_Version_Information
- Help4.x:Admin_Modules:_Logged-in_Users
- Help4.x:Admin_Modules:_Login_Form
- Help4.x:Admin_Modules:_Login_Support_Information
- Help4.x:Admin_Modules:_Messages
- Help4.x:Admin_Modules:_Multilingual_Status
- Help4.x:Admin_Modules:_Popular_Articles
- Help4.x:Admin_Modules:_Post_Installation_Messages
- Help4.x:Admin_Modules:_Privacy_Dashboard
- Help4.x:Admin_Modules:_Privacy_Status_Check
- Help4.x:Admin_Modules:_Quick_Icons
- Help4.x:Admin_Modules:_Sample_Data
- Help4.x:Admin_Modules:_Title
- Help4.x:Admin_Modules:_Toolbar
- Help4.x:Admin_Modules:_User_Menu

### articles 
- Help4.x:Articles
- Help4.x:Articles:_Categories
- Help4.x:Articles:_Edit
- Help4.x:Articles:_Featured
- Help4.x:Articles:_New_or_Edit_Category
- Help4.x:Articles:_Options

### banners 
- Help4.x:Banners
- Help4.x:Banners:_Categories
- Help4.x:Banners:_Clients
- Help4.x:Banners:_Edit
- Help4.x:Banners:_New_or_Edit_Category
- Help4.x:Banners:_New_or_Edit_Client
- Help4.x:Banners:_Options
- Help4.x:Banners:_Tracks

### cache 
- Help4.x:Cache:_Options
- Help4.x:Check-in:_Options

### chunks 
- Help4.x:Chunks

### component 
- Help4.x:Component:_Field_Groups
- Help4.x:Component:_New_or_Edit_Field_Group
- Help4.x:Component:_Fields
- Help4.x:Component:_New_or_Edit_Field

### components 
- Help4.x:Components_Banners_Banners_Edit
- Help4.x:Components_Banners_Banners_Options
- Help4.x:Components_Check-in_Configuration
- Help4.x:Components_Patch_Tester_Options
- Help4.x:Components_Plug-in_Manager_Options
- Help4.x:Components_Privacy_Outline
- Help4.x:Components_Search
- Help4.x:Components_Search_Manager_Options
- Help4.x:Components_Version_History
- Help4.x:Components_Web_Links_Manager_Options
- Help4.x:Components_Weblinks_Categories
- Help4.x:Components_Weblinks_Categories_Edit
- Help4.x:Components_Weblinks_Links
- Help4.x:Components_Weblinks_Links_Edit

### contacts 
- Help4.x:Contacts
- Help4.x:Contacts:_Categories
- Help4.x:Contacts:_New_or_Edit
- Help4.x:Contacts:_New_or_Edit_Category
- Help4.x:Contacts:_Options

### content-security-policy 
- Help4.x:Content_Security_Policy:_Options
- Help4.x:Content_Security_Policy_Reports

### editors 
- Help4.x:Editors
- Help4.x:TinyMCE

### extensions 
- Help4.x:Extensions:_Discover
- Help4.x:Extensions:_Install
- Help4.x:Extensions:_Languages
- Help4.x:Extensions:_Manage
- Help4.x:Extensions:_Update
- Help4.x:Extensions_Extension_Manager_Languages
- Help4.x:Extensions_Module_Manager_Admin_Status_Unused
- Help4.x:Extensions_Module_Manager_Articles_Categories
- Help4.x:Extensions_Module_Manager_Edit
- Help4.x:Extensions_Module_Manager_Sample_Data
- Help4.x:Extensions_Module_Manager_Weblinks
- Help4.x:Extensions_Modules_Administrator

### glossary 
- Help4.x:Glossary

### guided-tours
- Help4.x:Guided_Tours:_Tours
- Help4.x:Guided_Tours:_New_or_Edit_Tour
- Help4.x:Guided_Tours:_Steps
- Help4.x:Guided_Tours:_New_or_Edit_Step
- Help4.x:Guided_Tours:_Options

### help-screens 
- Help4.x:Help_screens_styleguide

### information 
- Help4.x:Information:_Database
- Help4.x:Information:_Warnings

### install-or-update 
- Help4.x:Installer:_Options
- Help4.x:Joomla_Update
- Help4.x:Joomla_Update:_Options
- Help4.x:Joomla_Version_4_0_0
- Help4.x:Joomla_Version_4_0_1
- Help4.x:Joomla_Version_4_0_2
- Help4.x:Joomla_Version_4_0_3
- Help4.x:Joomla_Version_4_0_4
- Help4.x:Joomla_Version_Additional_Information
- Help4.x:Joomla_Version_Information

### languages 
- Help4.x:Languages:_Content
- Help4.x:Languages:_Edit_Content_Language
- Help4.x:Languages:_Edit_Override
- Help4.x:Languages:_Installed
- Help4.x:Languages:_Options
- Help4.x:Languages:_Overrides

### mail 
- Help4.x:Mail_Template:_Edit
- Help4.x:Mail_Templates
- Help4.x:Mail_Templates:_Options
- Help4.x:Maintenance:_Clear_Cache
- Help4.x:Maintenance:_Global_Check-in
- Help4.x:Mass_Mail_Users

### media 
- Help4.x:Media
- Help4.x:Media:_Options

### menu-items 
- Help4.x:Menu_Item:_Alias
- Help4.x:Menu_Item:_Article_Archived
- Help4.x:Menu_Item:_Category_Blog
- Help4.x:Menu_Item:_Category_List
- Help4.x:Menu_Item:_Compact_List_of_Tagged_Items
- Help4.x:Menu_Item:_Components_Menu_Container
- Help4.x:Menu_Item:_Confirm_Request
- Help4.x:Menu_Item:_Create_Article
- Help4.x:Menu_Item:_Create_Contact
- Help4.x:Menu_Item:_Create_Request
- Help4.x:Menu_Item:_Display_Template_Options
- Help4.x:Menu_Item:_Edit_User_Profile
- Help4.x:Menu_Item:_Extend_Consent
- Help4.x:Menu_Item:_Featured_Articles
- Help4.x:Menu_Item:_Featured_Contacts
- Help4.x:Menu_Item:_Heading
- Help4.x:Menu_Item:_Iframe_Wrapper
- Help4.x:Menu_Item:_List_All_Categories
- Help4.x:Menu_Item:_List_All_Contact_Categories
- Help4.x:Menu_Item:_List_All_News_Feed_Categories
- Help4.x:Menu_Item:_List_All_Tags
- Help4.x:Menu_Item:_List_Contacts_in_a_Category
- Help4.x:Menu_Item:_List_News_Feeds_in_a_Category
- Help4.x:Menu_Item:_Login_Form
- Help4.x:Menu_Item:_Logout
- Help4.x:Menu_Item:_New_Item
- Help4.x:Menu_Item:_Password_Reset
- Help4.x:Menu_Item:_Registration_Form
- Help4.x:Menu_Item:_Search
- Help4.x:Menu_Item:_Separator
- Help4.x:Menu_Item:_Single_Article
- Help4.x:Menu_Item:_Single_Contact
- Help4.x:Menu_Item:_Single_News_Feed
- Help4.x:Menu_Item:_Site_Configuration_Options
- Help4.x:Menu_Item:_Tagged_Items
- Help4.x:Menu_Item:_URL
- Help4.x:Menu_Item:_User_Profile
- Help4.x:Menu_Item:_Username_Reminder_Request

### menus 
- Help4.x:Menus
- Help4.x:Menus:_Edit
- Help4.x:Menus:_Items
- Help4.x:Menus:_Options
- Help4.x:Menus_Menu_Item_Search_Results
- Help4.x:Menus_Menu_Item_Weblink_Categories
- Help4.x:Menus_Menu_Item_Weblink_Category
- Help4.x:Menus_Menu_Item_Weblink_Submit
- Help4.x:Menus_Menu_Manager_Options

### messages 
- Help4.x:Messages:_Options

### modules 
- Help4.x:Module:_Options
- Help4.x:Modules

### multilingual-associations
- Help4.x:Multilingual_Associations
- Help4.x:Multilingual_Associations:_Edit
- Help4.x:Multilingual_Associations:_Options

### my-profile 
- Help4.x:My_Profile

### news-feed 
- Help4.x:News_Feed:_Options
- Help4.x:News_Feeds
- Help4.x:News_Feeds:_Categories
- Help4.x:News_Feeds:_New_or_Edit
- Help4.x:News_Feeds:_New_or_Edit_Category

### permissions 
- Help4.x:Permissions_for_Group
- Help4.x:Permissions_for_User

### plugins 
- Help4.x:Plugin:_Options
- Help4.x:Plugins
- Help4.x:Plugins:_Name_of_Plugin

### post-install-messages 
- Help4.x:Post-installation_Messages:_Options
- Help4.x:Post-installation_Messages_for_Joomla_CMS

### privacy 
- Help4.x:Privacy:_Consents
- Help4.x:Privacy:_Extension_Capabilities
- Help4.x:Privacy:_Information_Requests
- Help4.x:Privacy:_New_Information_Request
- Help4.x:Privacy:_Options
- Help4.x:Privacy:_Review_Information_Request
- Help4.x:Privacy_Dashboard
- Help4.x:Private_Messages

### private-messages 
- Help4.x:Private_Messages:_Read
- Help4.x:Private_Messages:_Write

### redirect 
- Help4.x:Redirect:_Options
- Help4.x:Redirects:_Links
- Help4.x:Redirects:_New_or_Edit

### site 
- Help4.x:Site_Control_Panel
- Help4.x:Site_Global_Configuration
- Help4.x:Site_Global_Configuration_Logging
- Help4.x:Site_Global_Configuration_Permissions
- Help4.x:Site_Global_Configuration_Server
- Help4.x:Site_Global_Configuration_Site
- Help4.x:Site_Global_Configuration_System
- Help4.x:Site_Global_Configuration_Text_Filters
- Help4.x:Site_System_Information

### site-modules 
- Help4.x:Site_Modules:_Articles_-_Archived
- Help4.x:Site_Modules:_Articles_-_Categories
- Help4.x:Site_Modules:_Articles_-_Category
- Help4.x:Site_Modules:_Articles_-_Latest
- Help4.x:Site_Modules:_Articles_-_Most_Read
- Help4.x:Site_Modules:_Articles_-_Newsflash
- Help4.x:Site_Modules:_Articles_-_Related
- Help4.x:Site_Modules:_Banners
- Help4.x:Site_Modules:_Breadcrumbs
- Help4.x:Site_Modules:_Custom
- Help4.x:Site_Modules:_Feed_Display
- Help4.x:Site_Modules:_Footer
- Help4.x:Site_Modules:_Language_Switcher
- Help4.x:Site_Modules:_Latest_Users
- Help4.x:Site_Modules:_Login
- Help4.x:Site_Modules:_Menu
- Help4.x:Site_Modules:_Random_Image
- Help4.x:Site_Modules:_Smart_Search
- Help4.x:Site_Modules:_Statistics
- Help4.x:Site_Modules:_Syndication_Feeds
- Help4.x:Site_Modules:_Tags_-_Popular
- Help4.x:Site_Modules:_Tags_-_Similar
- Help4.x:Site_Modules:_Who\'s_Online
- Help4.x:Site_Modules:_Wrapper

### smart-search 
- Help4.x:Smart_Search:_Content_Maps
- Help4.x:Smart_Search:_Indexed_Content
- Help4.x:Smart_Search:_New_or_Edit_Filter
- Help4.x:Smart_Search:_Options
- Help4.x:Smart_Search:_Search_Filters
- Help4.x:Smart_Search:_Search_Term_Analysis

### tags 
- Help4.x:Tags
- Help4.x:Tags:_New_or_Edit
- Help4.x:Tags:_Options

### templates 
- Help4.x:Template:_Options
- Help4.x:Templates:_Customise
- Help4.x:Templates:_Customise_Source
- Help4.x:Templates:_Edit_Style
- Help4.x:Templates:_Styles
- Help4.x:Templates:_Templates

### update-sites 
- Help4.x:Edit_Update_Site
- Help4.x:Extensions:_Update_Sites

### users 
- Help4.x:User_Actions_Log
- Help4.x:User_Actions_Log:_Options
- Help4.x:User_Notes
- Help4.x:User_Notes:_Categories
- Help4.x:User_Notes:_New_or_Edit
- Help4.x:User_Notes:_New_or_Edit_Category
- Help4.x:Users
- Help4.x:Users:_Edit_Profile
- Help4.x:Users:_Edit_Viewing_Access_Level
- Help4.x:Users:_Groups
- Help4.x:Users:_New_or_Edit_Group
- Help4.x:Users:_Options
- Help4.x:Users:_Viewing_Access_Levels

### workflow 
- Help4.x:Stages_List:_Basic_Workflow
- Help4.x:Transitions_List:_Basic_Workflow
- Help4.x:Workflows_List
', 3, 4, 1),
(3, 'developer', 'Joomla 4 Developer Manual', 'https://docs.joomla.org/J4.x:Joomla_4_Developer_Manual', 'https://docs.joomla.org/', '### getting-started
- J4.x:Developer:_Required_Software
- XAMPP
- J4.x:Apache_PHP_Handler
- J4.x:Developer:_File_Structure
- Visual_Studio_Code_Primer
- J4.x:Developer:_Eclipse_PDT

### developer-information
- J4.x:Setting_Up_Your_Local_Environment
- Working_with_git_and_github
- Setting_up_Eclipse_PDT_2020_and_Git_for_Pulls
- Manifest_files
- J4.x:Namespace_Conventions_In_Joomla
- J4.x:Web_Assets
- J4.x:Dependency_Injection_in_Joomla_4
- J4.x:Joomla_Core_APIs
- API_Guides
- Deploying_an_Update_Server
- Joomla_CodeSniffer

### plugin-development
- J4.x:Creating_a_Plugin_for_Joomla
- J4.x:Creating_an_Authentication_Plugin_for_Joomla
- Creating_a_Smart_Search_plug-in
- J4.x:Triggering_content_plugins_in_your_extension
- J4.x:Cloud_File_Systems_for_Media_Manager
- J4.x:J4_Plugin_example_-_Table_of_Contents

### module-development
- J4.x:Creating_a_Simple_Module
- J4.x:J4_Module_example_-_Mydownmsg

### developing-an-mvc-component
- J4.x:Developing_an_MVC_Component
- J4.x:Developing_an_MVC_Component/Introduction
- J4.x:Developing_an_MVC_Component/Developing_a_Basic_Component
- J4.x:Developing_an_MVC_Component/Adding_a_View_to_the_Site_Part
- J4.x:Developing_an_MVC_Component/Adding_a_Menu_Type_to_the_Site_Part
- J4.x:Developing_an_MVC_Component/Language_Management
- J4.x:Developing_an_MVC_Component/Adding_a_Model_to_the_Site_Part
- J4.x:Developing_an_MVC_Component/Adding_a_Request_Variable_in_the_Menu_Link
- J4.x:Developing_an_MVC_Component/Setting_up_the_Database
- J4.x:Adding_an_API_to_a_Joomla_Component

### mvc-anatomy
- J4.x:MVC_Anatomy:_Getting_Started
- J4.x:MVC_Anatomy:_File_Structure
- J4.x:MVC_Anatomy:_Manifest_File
- J4.x:MVC_Anatomy:_Site_Files
- J4.x:MVC_Anatomy:_Administrator_Startup_Files
- J4.x:MVC_Anatomy:_Administrator_Edit_Files

### mvc-examples
- J4.x:J4_Component_example_-_Mywalks
- J4.x:My_Walks_Part_1:_The_Site_code
- J4.x:My_Walks_Part_2:_The_Administrator_code
- J4.x:J4_Developer_Resources

### cli-development
- J4.x:Writing_A_CLI_Application
- J4.x:CLI_Database_Exporter_Importer
- J4.x:CLI_Update
- J4.x:CLI_example_-_Onoffbydate

### database
- J4.x:Moving_Joomla_To_Prepared_Statements
- J4.x:Selecting_data_using_JDatabase
- J4.x:Inserting_Updating_and_Removing_data_using_JDatabase

### coding-examples
- J4.x:Tips_and_Tricks_for_Joomla_4_Developers
- J4.x:Using_Bootstrap_Components_in_Joomla_4

### advanced-developer
- J4.x:Automated_System_Testing
- J4.x:SCSS_and_Sass

### advanced-administrator
- J4.x:Http_Header_Management
- J4.x:Improved_Override_Management

### unclassified
- J4.x:Joomla_Entities
- J4.x:Changed_parameters_for_template_providers
- J4.x:ClientSideEvents
- J4.x:Page_Builder
- J4.x:Response_Formats
', 5, 6, 1),
(4, 'docs', 'Joomla 4 Documenter Manual', 'https://docs.joomla.org/J4.x:Joomla_4_Documentor_Manual_Index', 'https://docs.joomla.org/', NULL, 7, 8, 0);

CREATE TABLE IF NOT EXISTS `#__jdocmanual_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manual` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` char(8) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `menu` mediumtext COLLATE utf8mb4_unicode_ci,
  `state` tinyint(4) NOT NULL DEFAULT '1',
  `last_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Populate the menus post-flight or on user start up or insert the default menu?

CREATE TABLE IF NOT EXISTS `#__jdocmanual_menu_headings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manual` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` char(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `heading` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_title` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=716 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO `#__jdocmanual_menu_headings` (`id`, `manual`, `language`, `heading`, `display_title`) VALUES
(1, 'user', 'en', 'getting-started', 'Getting Started'),
(2, 'user', 'en', 'articles', 'Articles'),
(3, 'user', 'en', 'articles-access', 'Articles - Access'),
(4, 'user', 'en', 'articles-metadata', 'Articles - Metadata'),
(5, 'user', 'en', 'banners', 'Banners'),
(6, 'user', 'en', 'command-line-interface', 'Command '),
(7, 'user', 'en', 'configuration', 'Configuration'),
(8, 'user', 'en', 'contacts', 'Contacts'),
(9, 'user', 'en', 'dashboards', 'Dashboards'),
(10, 'user', 'en', 'editors', 'Editors'),
(11, 'user', 'en', 'extensions', 'Extensions'),
(12, 'user', 'en', 'fields', 'Fields'),
(13, 'user', 'en', 'help', 'Help'),
(14, 'user', 'en', 'hosting', 'Hosting'),
(15, 'user', 'en', 'installation-variations', 'Installation Variations'),
(16, 'user', 'en', 'languages', 'Languages'),
(17, 'user', 'en', 'media', 'Media'),
(18, 'user', 'en', 'menus', 'Menus'),
(19, 'user', 'en', 'migration', 'Migration'),
(20, 'user', 'en', 'modules', 'Modules'),
(21, 'user', 'en', 'news-feeds', 'News Feeds'),
(22, 'user', 'en', 'performance', 'Performance'),
(23, 'user', 'en', 'plugins', 'Plugins'),
(24, 'user', 'en', 'privacy', 'Privacy'),
(25, 'user', 'en', 'problems', 'Problems'),
(26, 'user', 'en', 'reference', 'Reference'),
(27, 'user', 'en', 'security', 'Security'),
(28, 'user', 'en', 'seo', 'SEO'),
(29, 'user', 'en', 'smart-search', 'Smart Search'),
(30, 'user', 'en', 'system', 'System'),
(31, 'user', 'en', 'tags', 'Tags'),
(32, 'user', 'en', 'templates', 'Templates'),
(33, 'user', 'en', 'template-tips', 'Template Tips'),
(34, 'user', 'en', 'test-installations', 'Test Installations'),
(35, 'user', 'en', 'users', 'Users'),
(36, 'user', 'en', 'workflows', 'Workflows'),
(37, 'help', 'en', 'admin-modules', 'Admin Modules'),
(38, 'help', 'en', 'articles', 'Articles'),
(39, 'help', 'en', 'banners', 'Banners'),
(40, 'help', 'en', 'cache', 'Cache'),
(41, 'help', 'en', 'chunks', 'Chunks'),
(42, 'help', 'en', 'component', 'Component'),
(43, 'help', 'en', 'components', 'Components'),
(44, 'help', 'en', 'contacts', 'Contacts'),
(45, 'help', 'en', 'content-security-policy', 'Contact Security Policy'),
(46, 'help', 'en', 'editors', 'Editors'),
(47, 'help', 'en', 'extensions', 'Extensions'),
(48, 'help', 'en', 'fields', 'Fields'),
(49, 'help', 'en', 'glossary', 'Glossary'),
(50, 'help', 'en', 'help-screens', 'Help Screens'),
(51, 'help', 'en', 'information', 'Infromation'),
(52, 'help', 'en', 'install-or-update', 'Install or Update'),
(53, 'help', 'en', 'languages', 'Languages'),
(54, 'help', 'en', 'mail', 'Mail'),
(55, 'help', 'en', 'media', 'Media'),
(56, 'help', 'en', 'menu-items', 'Menu-items'),
(57, 'help', 'en', 'menus', 'Menus'),
(58, 'help', 'en', 'messages', 'Messages'),
(59, 'help', 'en', 'modules', 'Modules'),
(60, 'help', 'en', 'multilingual-associations', 'Multilingual Associations'),
(61, 'help', 'en', 'my-profile', 'My Profile'),
(62, 'help', 'en', 'news-feed', 'News Feed'),
(63, 'help', 'en', 'permissions', 'Permissions'),
(64, 'help', 'en', 'plugins', 'Plugins'),
(65, 'help', 'en', 'post-install-messages', 'Post-install Messages'),
(66, 'help', 'en', 'privacy', 'Privacy'),
(67, 'help', 'en', 'private-messages', 'Private Messages'),
(68, 'help', 'en', 'redirect', 'Redirect'),
(69, 'help', 'en', 'site', 'Site'),
(70, 'help', 'en', 'site-modules', 'Site Modules'),
(71, 'help', 'en', 'smart-search', 'Smart Search'),
(72, 'help', 'en', 'tags', 'Tags'),
(73, 'help', 'en', 'templates', 'Templates'),
(74, 'help', 'en', 'update-sites', 'Update Sites'),
(75, 'help', 'en', 'users', 'Users'),
(76, 'help', 'en', 'workflow', 'Workflow'),
(77, 'developer', 'en', 'getting-started', 'Getting Started'),
(78, 'developer', 'en', 'developer-information', 'Developer Information'),
(79, 'developer', 'en', 'plugin-development', 'Plugin Development'),
(80, 'developer', 'en', 'module-development', 'Module Development'),
(81, 'developer', 'en', 'developing-an-mvc-component', 'Developing an MVC Component'),
(82, 'developer', 'en', 'mvc-anatomy', 'MVC Anatomy'),
(83, 'developer', 'en', 'mvc-examples', 'MVC Examples'),
(84, 'developer', 'en', 'cli-development', 'CLI Development'),
(85, 'developer', 'en', 'database', 'Database'),
(86, 'developer', 'en', 'coding-examples', 'Coding Examples'),
(87, 'developer', 'en', 'advanced-developer', 'Advanced Developer'),
(88, 'developer', 'en', 'advanced-administrator', 'Advanced Administrator'),
(89, 'developer', 'en', 'unclassified', 'Unclassified'),
(90, 'help', 'de', 'admin-modules', 'Admin-Module'),
(91, 'help', 'de', 'articles', 'Artikel'),
(92, 'help', 'de', 'banners', 'Banner'),
(93, 'help', 'de', 'cache', 'Zwischenspeicher'),
(94, 'help', 'de', 'chunks', 'Brocken'),
(95, 'help', 'de', 'component', 'Komponente'),
(96, 'help', 'de', 'components', 'Komponenten'),
(97, 'help', 'de', 'contacts', 'Kontakte'),
(98, 'help', 'de', 'content-security-policy', 'Wenden Sie sich an die Sicherheitsrichtlinie'),
(99, 'help', 'de', 'editors', 'Redakteure'),
(100, 'help', 'de', 'extensions', 'Erweiterungen'),
(101, 'help', 'de', 'fields', 'Felder'),
(102, 'help', 'de', 'glossary', 'Glossar'),
(103, 'help', 'de', 'help-screens', 'Hilfebildschirme'),
(104, 'help', 'de', 'information', 'Informationen'),
(105, 'help', 'de', 'install-or-update', 'Installieren oder aktualisieren'),
(106, 'help', 'de', 'languages', 'Sprachen'),
(107, 'help', 'de', 'mail', 'Post'),
(108, 'help', 'de', 'media', 'Medien'),
(109, 'help', 'de', 'menu-items', 'Menüpunkte'),
(110, 'help', 'de', 'menus', 'Menüs'),
(111, 'help', 'de', 'messages', 'Mitteilungen'),
(112, 'help', 'de', 'modules', 'Module'),
(113, 'help', 'de', 'multilingual-associations', 'Mehrsprachige Verbände'),
(114, 'help', 'de', 'my-profile', 'Mein Profil'),
(115, 'help', 'de', 'news-feed', 'Neuigkeiten'),
(116, 'help', 'de', 'permissions', 'Berechtigungen'),
(117, 'help', 'de', 'plugins', 'Plugins'),
(118, 'help', 'de', 'post-install-messages', 'Nachrichten nach der Installation'),
(119, 'help', 'de', 'privacy', 'Privatsphäre'),
(120, 'help', 'de', 'private-messages', 'Private Nachrichten'),
(121, 'help', 'de', 'redirect', 'Umleiten'),
(122, 'help', 'de', 'site', 'Grundstück'),
(123, 'help', 'de', 'site-modules', 'Site-Module'),
(124, 'help', 'de', 'smart-search', 'Intelligente Suche'),
(125, 'help', 'de', 'tags', 'Stichworte'),
(126, 'help', 'de', 'templates', 'Vorlagen'),
(127, 'help', 'de', 'update-sites', 'Websites aktualisieren'),
(128, 'help', 'de', 'users', 'Benutzer'),
(129, 'help', 'de', 'workflow', 'Arbeitsablauf'),
(130, 'user', 'de', 'getting-started', 'Einstieg'),
(131, 'user', 'de', 'articles', 'Artikel'),
(132, 'user', 'de', 'articles-access', 'Artikel - Zugang'),
(133, 'user', 'de', 'articles-metadata', 'Artikel - Metadaten'),
(134, 'user', 'de', 'banners', 'Banner'),
(135, 'user', 'de', 'command-line-interface', 'Befehl'),
(136, 'user', 'de', 'configuration', 'Aufbau'),
(137, 'user', 'de', 'contacts', 'Kontakte'),
(138, 'user', 'de', 'dashboards', 'Dashboards'),
(139, 'user', 'de', 'editors', 'Redakteure'),
(140, 'user', 'de', 'extensions', 'Erweiterungen'),
(141, 'user', 'de', 'fields', 'Felder'),
(142, 'user', 'de', 'help', 'Hilfe'),
(143, 'user', 'de', 'hosting', 'Gastgeber'),
(144, 'user', 'de', 'installation-variations', 'Installationsvarianten'),
(145, 'user', 'de', 'languages', 'Sprachen'),
(146, 'user', 'de', 'media', 'Medien'),
(147, 'user', 'de', 'menus', 'Menüs'),
(148, 'user', 'de', 'migration', 'Migration'),
(149, 'user', 'de', 'modules', 'Module'),
(150, 'user', 'de', 'news-feeds', 'News-Feeds'),
(151, 'user', 'de', 'performance', 'Leistung'),
(152, 'user', 'de', 'plugins', 'Plugins'),
(153, 'user', 'de', 'privacy', 'Privatsphäre'),
(154, 'user', 'de', 'problems', 'Probleme'),
(155, 'user', 'de', 'reference', 'Referenz'),
(156, 'user', 'de', 'security', 'Sicherheit'),
(157, 'user', 'de', 'seo', 'SEO'),
(158, 'user', 'de', 'smart-search', 'Intelligente Suche'),
(159, 'user', 'de', 'system', 'System'),
(160, 'user', 'de', 'tags', 'Stichworte'),
(161, 'user', 'de', 'templates', 'Vorlagen'),
(162, 'user', 'de', 'template-tips', 'Vorlagen-Tipps'),
(163, 'user', 'de', 'test-installations', 'Testinstallationen'),
(164, 'user', 'de', 'users', 'Benutzer'),
(165, 'user', 'de', 'workflows', 'Arbeitsabläufe'),
(166, 'developer', 'de', 'getting-started', 'Einstieg'),
(167, 'developer', 'de', 'developer-information', 'Entwicklerinformationen'),
(168, 'developer', 'de', 'plugin-development', 'Plugin-Entwicklung'),
(169, 'developer', 'de', 'module-development', 'Modulentwicklung'),
(170, 'developer', 'de', 'developing-an-mvc-component', 'Entwicklung einer MVC-Komponente'),
(171, 'developer', 'de', 'mvc-anatomy', 'MVC-Anatomie'),
(172, 'developer', 'de', 'mvc-examples', 'MVC-Beispiele'),
(173, 'developer', 'de', 'cli-development', 'CLI-Entwicklung'),
(174, 'developer', 'de', 'database', 'Datenbank'),
(175, 'developer', 'de', 'coding-examples', 'Codierungsbeispiele'),
(176, 'developer', 'de', 'advanced-developer', 'Fortgeschrittener Entwickler'),
(177, 'developer', 'de', 'advanced-administrator', 'Erweiterter Administrator'),
(178, 'developer', 'de', 'unclassified', 'Nicht klassifiziert'),
(179, 'help', 'fr', 'admin-modules', 'Modules d\'administration'),
(180, 'help', 'fr', 'articles', 'Des articles'),
(181, 'help', 'fr', 'banners', 'Bannières'),
(182, 'help', 'fr', 'cache', 'Cache'),
(183, 'help', 'fr', 'chunks', 'Morceaux'),
(184, 'help', 'fr', 'component', 'Composant'),
(185, 'help', 'fr', 'components', 'Composants'),
(186, 'help', 'fr', 'contacts', 'Contacts'),
(187, 'help', 'fr', 'content-security-policy', 'Contacter la politique de sécurité'),
(188, 'help', 'fr', 'editors', 'Éditeurs'),
(189, 'help', 'fr', 'extensions', 'Rallonges'),
(190, 'help', 'fr', 'fields', 'Des champs'),
(191, 'help', 'fr', 'glossary', 'Glossaire'),
(192, 'help', 'fr', 'help-screens', 'Écrans d\'aide'),
(193, 'help', 'fr', 'information', 'Informations'),
(194, 'help', 'fr', 'install-or-update', 'Installer ou mettre à jour'),
(195, 'help', 'fr', 'languages', 'Langues'),
(196, 'help', 'fr', 'mail', 'Poster'),
(197, 'help', 'fr', 'media', 'médias'),
(198, 'help', 'fr', 'menu-items', 'éléments de menu'),
(199, 'help', 'fr', 'menus', 'Menus'),
(200, 'help', 'fr', 'messages', 'messages'),
(201, 'help', 'fr', 'modules', 'Modules'),
(202, 'help', 'fr', 'multilingual-associations', 'Associations multilingues'),
(203, 'help', 'fr', 'my-profile', 'Mon profil'),
(204, 'help', 'fr', 'news-feed', 'Fil d\'actualité'),
(205, 'help', 'fr', 'permissions', 'Autorisations'),
(206, 'help', 'fr', 'plugins', 'Plugins'),
(207, 'help', 'fr', 'post-install-messages', 'Messages post-installation'),
(208, 'help', 'fr', 'privacy', 'Confidentialité'),
(209, 'help', 'fr', 'private-messages', 'Messages privés'),
(210, 'help', 'fr', 'redirect', 'Réorienter'),
(211, 'help', 'fr', 'site', 'Placer'),
(212, 'help', 'fr', 'site-modules', 'Modules de site'),
(213, 'help', 'fr', 'smart-search', 'Recherche intelligente'),
(214, 'help', 'fr', 'tags', 'Mots clés'),
(215, 'help', 'fr', 'templates', 'Modèles'),
(216, 'help', 'fr', 'update-sites', 'Mettre à jour les sites'),
(217, 'help', 'fr', 'users', 'Utilisateurs'),
(218, 'help', 'fr', 'workflow', 'Flux de travail'),
(219, 'user', 'fr', 'getting-started', 'Commencer'),
(220, 'user', 'fr', 'articles', 'Des articles'),
(221, 'user', 'fr', 'articles-access', 'Articles - Accès'),
(222, 'user', 'fr', 'articles-metadata', 'Articles - Métadonnées'),
(223, 'user', 'fr', 'banners', 'Bannières'),
(224, 'user', 'fr', 'command-line-interface', 'Commande'),
(225, 'user', 'fr', 'configuration', 'Configuration'),
(226, 'user', 'fr', 'contacts', 'Contacts'),
(227, 'user', 'fr', 'dashboards', 'Tableaux de bord'),
(228, 'user', 'fr', 'editors', 'Éditeurs'),
(229, 'user', 'fr', 'extensions', 'Rallonges'),
(230, 'user', 'fr', 'fields', 'Des champs'),
(231, 'user', 'fr', 'help', 'Aider'),
(232, 'user', 'fr', 'hosting', 'Hébergement'),
(233, 'user', 'fr', 'installation-variations', 'Variantes d\'installation'),
(234, 'user', 'fr', 'languages', 'Langues'),
(235, 'user', 'fr', 'media', 'Médias'),
(236, 'user', 'fr', 'menus', 'Menus'),
(237, 'user', 'fr', 'migration', 'Migration'),
(238, 'user', 'fr', 'modules', 'Modules'),
(239, 'user', 'fr', 'news-feeds', 'Fil d\'actualité'),
(240, 'user', 'fr', 'performance', 'Performance'),
(241, 'user', 'fr', 'plugins', 'Plugins'),
(242, 'user', 'fr', 'privacy', 'Confidentialité'),
(243, 'user', 'fr', 'problems', 'Problèmes'),
(244, 'user', 'fr', 'reference', 'Référence'),
(245, 'user', 'fr', 'security', 'Sécurité'),
(246, 'user', 'fr', 'seo', 'référencement'),
(247, 'user', 'fr', 'smart-search', 'Recherche intelligente'),
(248, 'user', 'fr', 'system', 'Système'),
(249, 'user', 'fr', 'tags', 'Mots clés'),
(250, 'user', 'fr', 'templates', 'Modèles'),
(251, 'user', 'fr', 'template-tips', 'Conseils sur les modèles'),
(252, 'user', 'fr', 'test-installations', 'Installations d\'essai'),
(253, 'user', 'fr', 'users', 'Utilisateurs'),
(254, 'user', 'fr', 'workflows', 'Flux de travail'),
(255, 'developer', 'fr', 'getting-started', 'Commencer'),
(256, 'developer', 'fr', 'developer-information', 'Informations pour les développeurs'),
(257, 'developer', 'fr', 'plugin-development', 'Développement de plugins'),
(258, 'developer', 'fr', 'module-development', 'Développement de modules'),
(259, 'developer', 'fr', 'developing-an-mvc-component', 'Développement d\'un composant MVC'),
(260, 'developer', 'fr', 'mvc-anatomy', 'Anatomie MVC'),
(261, 'developer', 'fr', 'mvc-examples', 'Exemples MVC'),
(262, 'developer', 'fr', 'cli-development', 'Développement CLI'),
(263, 'developer', 'fr', 'database', 'Base de données'),
(264, 'developer', 'fr', 'coding-examples', 'Exemples de codage'),
(265, 'developer', 'fr', 'advanced-developer', 'Développeur avancé'),
(266, 'developer', 'fr', 'advanced-administrator', 'Administrateur avancé'),
(267, 'developer', 'fr', 'unclassified', 'Non classé'),
(268, 'help', 'es', 'admin-modules', 'Módulos de administración'),
(269, 'help', 'es', 'articles', 'Artículos'),
(270, 'help', 'es', 'banners', 'pancartas'),
(271, 'help', 'es', 'cache', 'Cache'),
(272, 'help', 'es', 'chunks', 'Trozos'),
(273, 'help', 'es', 'component', 'Componente'),
(274, 'help', 'es', 'components', 'Componentes'),
(275, 'help', 'es', 'contacts', 'Contactos'),
(276, 'help', 'es', 'content-security-policy', 'Política de seguridad de contacto'),
(277, 'help', 'es', 'editors', 'Editores'),
(278, 'help', 'es', 'extensions', 'Extensiones'),
(279, 'help', 'es', 'fields', 'Campos'),
(280, 'help', 'es', 'glossary', 'Glosario'),
(281, 'help', 'es', 'help-screens', 'Pantallas de ayuda'),
(282, 'help', 'es', 'information', 'Información'),
(283, 'help', 'es', 'install-or-update', 'Instalar o Actualizar'),
(284, 'help', 'es', 'languages', 'Idiomas'),
(285, 'help', 'es', 'mail', 'Correo'),
(286, 'help', 'es', 'media', 'medios de comunicación'),
(287, 'help', 'es', 'menu-items', 'elementos de menú'),
(288, 'help', 'es', 'menus', 'Menús'),
(289, 'help', 'es', 'messages', 'Mensajes'),
(290, 'help', 'es', 'modules', 'Módulos'),
(291, 'help', 'es', 'multilingual-associations', 'Asociaciones Multilingües'),
(292, 'help', 'es', 'my-profile', 'Mi perfil'),
(293, 'help', 'es', 'news-feed', 'Noticias'),
(294, 'help', 'es', 'permissions', 'permisos'),
(295, 'help', 'es', 'plugins', 'Complementos'),
(296, 'help', 'es', 'post-install-messages', 'Mensajes posteriores a la instalación'),
(297, 'help', 'es', 'privacy', 'Privacidad'),
(298, 'help', 'es', 'private-messages', 'mensajes privados'),
(299, 'help', 'es', 'redirect', 'redirigir'),
(300, 'help', 'es', 'site', 'Sitio'),
(301, 'help', 'es', 'site-modules', 'Módulos del sitio'),
(302, 'help', 'es', 'smart-search', 'Busqueda inteligente'),
(303, 'help', 'es', 'tags', 'Etiquetas'),
(304, 'help', 'es', 'templates', 'Plantillas'),
(305, 'help', 'es', 'update-sites', 'Actualizar sitios'),
(306, 'help', 'es', 'users', 'Usuarios'),
(307, 'help', 'es', 'workflow', 'flujo de trabajo'),
(308, 'user', 'es', 'getting-started', 'Empezando'),
(309, 'user', 'es', 'articles', 'Artículos'),
(310, 'user', 'es', 'articles-access', 'Artículos - Acceso'),
(311, 'user', 'es', 'articles-metadata', 'Artículos - Metadatos'),
(312, 'user', 'es', 'banners', 'pancartas'),
(313, 'user', 'es', 'command-line-interface', 'Dominio'),
(314, 'user', 'es', 'configuration', 'Configuración'),
(315, 'user', 'es', 'contacts', 'Contactos'),
(316, 'user', 'es', 'dashboards', 'Tableros'),
(317, 'user', 'es', 'editors', 'Editores'),
(318, 'user', 'es', 'extensions', 'Extensiones'),
(319, 'user', 'es', 'fields', 'Campos'),
(320, 'user', 'es', 'help', 'Ayuda'),
(321, 'user', 'es', 'hosting', 'Alojamiento'),
(322, 'user', 'es', 'installation-variations', 'Variaciones de instalación'),
(323, 'user', 'es', 'languages', 'Idiomas'),
(324, 'user', 'es', 'media', 'Medios de comunicación'),
(325, 'user', 'es', 'menus', 'Menús'),
(326, 'user', 'es', 'migration', 'Migración'),
(327, 'user', 'es', 'modules', 'Módulos'),
(328, 'user', 'es', 'news-feeds', 'Noticiero'),
(329, 'user', 'es', 'performance', 'Actuación'),
(330, 'user', 'es', 'plugins', 'Complementos'),
(331, 'user', 'es', 'privacy', 'Privacidad'),
(332, 'user', 'es', 'problems', 'Problemas'),
(333, 'user', 'es', 'reference', 'Referencia'),
(334, 'user', 'es', 'security', 'Seguridad'),
(335, 'user', 'es', 'seo', 'SEO'),
(336, 'user', 'es', 'smart-search', 'Busqueda inteligente'),
(337, 'user', 'es', 'system', 'Sistema'),
(338, 'user', 'es', 'tags', 'Etiquetas'),
(339, 'user', 'es', 'templates', 'Plantillas'),
(340, 'user', 'es', 'template-tips', 'Consejos de plantilla'),
(341, 'user', 'es', 'test-installations', 'Instalaciones de prueba'),
(342, 'user', 'es', 'users', 'Usuarios'),
(343, 'user', 'es', 'workflows', 'Flujos de trabajo'),
(344, 'developer', 'es', 'getting-started', 'Empezando'),
(345, 'developer', 'es', 'developer-information', 'Información del desarrollador'),
(346, 'developer', 'es', 'plugin-development', 'Desarrollo de complementos'),
(347, 'developer', 'es', 'module-development', 'Desarrollo de módulos'),
(348, 'developer', 'es', 'developing-an-mvc-component', 'Desarrollo de un componente MVC'),
(349, 'developer', 'es', 'mvc-anatomy', 'Anatomía de MVC'),
(350, 'developer', 'es', 'mvc-examples', 'Ejemplos de MVC'),
(351, 'developer', 'es', 'cli-development', 'Desarrollo CLI'),
(352, 'developer', 'es', 'database', 'Base de datos'),
(353, 'developer', 'es', 'coding-examples', 'Ejemplos de codificación'),
(354, 'developer', 'es', 'advanced-developer', 'Desarrollador avanzado'),
(355, 'developer', 'es', 'advanced-administrator', 'Administrador avanzado'),
(356, 'developer', 'es', 'unclassified', 'Desclasificado'),
(357, 'help', 'nl', 'admin-modules', 'Beheermodules'),
(358, 'help', 'nl', 'articles', 'Lidwoord'),
(359, 'help', 'nl', 'banners', 'spandoeken'),
(360, 'help', 'nl', 'cache', 'Cache'),
(361, 'help', 'nl', 'chunks', 'Brokken'),
(362, 'help', 'nl', 'component', 'Onderdeel'),
(363, 'help', 'nl', 'components', 'Componenten'),
(364, 'help', 'nl', 'contacts', 'Contacten'),
(365, 'help', 'nl', 'content-security-policy', 'Neem contact op met het beveiligingsbeleid'),
(366, 'help', 'nl', 'editors', 'Editors'),
(367, 'help', 'nl', 'extensions', 'Extensies'),
(368, 'help', 'nl', 'fields', 'Velden'),
(369, 'help', 'nl', 'glossary', 'Woordenlijst'),
(370, 'help', 'nl', 'help-screens', 'Help-schermen'),
(371, 'help', 'nl', 'information', 'Informatie'),
(372, 'help', 'nl', 'install-or-update', 'Installeren of updaten'),
(373, 'help', 'nl', 'languages', 'Talen'),
(374, 'help', 'nl', 'mail', 'Mail'),
(375, 'help', 'nl', 'media', 'media'),
(376, 'help', 'nl', 'menu-items', 'menu items'),
(377, 'help', 'nl', 'menus', 'Menu\'s'),
(378, 'help', 'nl', 'messages', 'Berichten'),
(379, 'help', 'nl', 'modules', 'modules'),
(380, 'help', 'nl', 'multilingual-associations', 'Meertalige verenigingen'),
(381, 'help', 'nl', 'my-profile', 'Mijn profiel'),
(382, 'help', 'nl', 'news-feed', 'Nieuwsfeed'),
(383, 'help', 'nl', 'permissions', 'Rechten'),
(384, 'help', 'nl', 'plugins', 'Plug-ins'),
(385, 'help', 'nl', 'post-install-messages', 'Berichten na installatie'),
(386, 'help', 'nl', 'privacy', 'Privacy'),
(387, 'help', 'nl', 'private-messages', 'Prive berichten'),
(388, 'help', 'nl', 'redirect', 'Omleiden'),
(389, 'help', 'nl', 'site', 'Site'),
(390, 'help', 'nl', 'site-modules', 'Site-modules'),
(391, 'help', 'nl', 'smart-search', 'Slim zoeken'),
(392, 'help', 'nl', 'tags', 'Labels'),
(393, 'help', 'nl', 'templates', 'Sjablonen'),
(394, 'help', 'nl', 'update-sites', 'Sites bijwerken'),
(395, 'help', 'nl', 'users', 'Gebruikers'),
(396, 'help', 'nl', 'workflow', 'Werkstroom'),
(397, 'user', 'nl', 'getting-started', 'Aan de slag'),
(398, 'user', 'nl', 'articles', 'Lidwoord'),
(399, 'user', 'nl', 'articles-access', 'Artikelen - Toegang'),
(400, 'user', 'nl', 'articles-metadata', 'Artikelen - Metagegevens'),
(401, 'user', 'nl', 'banners', 'spandoeken'),
(402, 'user', 'nl', 'command-line-interface', 'Commando'),
(403, 'user', 'nl', 'configuration', 'Configuratie'),
(404, 'user', 'nl', 'contacts', 'Contacten'),
(405, 'user', 'nl', 'dashboards', 'Dashboards'),
(406, 'user', 'nl', 'editors', 'Editors'),
(407, 'user', 'nl', 'extensions', 'Extensies'),
(408, 'user', 'nl', 'fields', 'Velden'),
(409, 'user', 'nl', 'help', 'Hulp'),
(410, 'user', 'nl', 'hosting', 'Hosting'),
(411, 'user', 'nl', 'installation-variations', 'Installatie variaties'),
(412, 'user', 'nl', 'languages', 'Talen'),
(413, 'user', 'nl', 'media', 'Media'),
(414, 'user', 'nl', 'menus', 'Menu\'s'),
(415, 'user', 'nl', 'migration', 'Migratie'),
(416, 'user', 'nl', 'modules', 'modules'),
(417, 'user', 'nl', 'news-feeds', 'Nieuwsfeeds'),
(418, 'user', 'nl', 'performance', 'Prestatie'),
(419, 'user', 'nl', 'plugins', 'Plug-ins'),
(420, 'user', 'nl', 'privacy', 'Privacy'),
(421, 'user', 'nl', 'problems', 'Problemen'),
(422, 'user', 'nl', 'reference', 'Referentie'),
(423, 'user', 'nl', 'security', 'Beveiliging'),
(424, 'user', 'nl', 'seo', 'SEO'),
(425, 'user', 'nl', 'smart-search', 'Slim zoeken'),
(426, 'user', 'nl', 'system', 'Systeem'),
(427, 'user', 'nl', 'tags', 'Labels'),
(428, 'user', 'nl', 'templates', 'Sjablonen'),
(429, 'user', 'nl', 'template-tips', 'Sjabloontips'),
(430, 'user', 'nl', 'test-installations', 'Installaties testen'),
(431, 'user', 'nl', 'users', 'Gebruikers'),
(432, 'user', 'nl', 'workflows', 'Werkstromen'),
(433, 'developer', 'nl', 'getting-started', 'Aan de slag'),
(434, 'developer', 'nl', 'developer-information', 'Ontwikkelaarsinformatie'),
(435, 'developer', 'nl', 'plugin-development', 'Ontwikkeling van plug-ins'),
(436, 'developer', 'nl', 'module-development', 'Module-ontwikkeling'),
(437, 'developer', 'nl', 'developing-an-mvc-component', 'Een MVC-component ontwikkelen'),
(438, 'developer', 'nl', 'mvc-anatomy', 'MVC-anatomie'),
(439, 'developer', 'nl', 'mvc-examples', 'MVC-voorbeelden'),
(440, 'developer', 'nl', 'cli-development', 'CLI-ontwikkeling'),
(441, 'developer', 'nl', 'database', 'Databank'),
(442, 'developer', 'nl', 'coding-examples', 'Codeervoorbeelden'),
(443, 'developer', 'nl', 'advanced-developer', 'Geavanceerde ontwikkelaar'),
(444, 'developer', 'nl', 'advanced-administrator', 'Geavanceerde beheerder'),
(445, 'developer', 'nl', 'unclassified', 'Niet geclassificeerd'),
(446, 'help', 'pt', 'admin-modules', 'Módulos Administrativos'),
(447, 'help', 'pt', 'articles', 'Artigos'),
(448, 'help', 'pt', 'banners', 'Banners'),
(449, 'help', 'pt', 'cache', 'Cache'),
(450, 'help', 'pt', 'chunks', 'Pedaços'),
(451, 'help', 'pt', 'component', 'Componente'),
(452, 'help', 'pt', 'components', 'Componentes'),
(453, 'help', 'pt', 'contacts', 'Contatos'),
(454, 'help', 'pt', 'content-security-policy', 'Política de segurança de contato'),
(455, 'help', 'pt', 'editors', 'Editores'),
(456, 'help', 'pt', 'extensions', 'Extensões'),
(457, 'help', 'pt', 'fields', 'Campos'),
(458, 'help', 'pt', 'glossary', 'Glossário'),
(459, 'help', 'pt', 'help-screens', 'Telas de ajuda'),
(460, 'help', 'pt', 'information', 'Informações'),
(461, 'help', 'pt', 'install-or-update', 'Instalar ou Atualizar'),
(462, 'help', 'pt', 'languages', 'línguas'),
(463, 'help', 'pt', 'mail', 'Correspondência'),
(464, 'help', 'pt', 'media', 'meios de comunicação'),
(465, 'help', 'pt', 'menu-items', 'itens do menu'),
(466, 'help', 'pt', 'menus', 'Menus'),
(467, 'help', 'pt', 'messages', 'mensagens'),
(468, 'help', 'pt', 'modules', 'Módulos'),
(469, 'help', 'pt', 'multilingual-associations', 'Associações multilíngues'),
(470, 'help', 'pt', 'my-profile', 'Meu perfil'),
(471, 'help', 'pt', 'news-feed', 'Notícias'),
(472, 'help', 'pt', 'permissions', 'Permissões'),
(473, 'help', 'pt', 'plugins', 'Plugins'),
(474, 'help', 'pt', 'post-install-messages', 'Mensagens pós-instalação'),
(475, 'help', 'pt', 'privacy', 'Privacidade'),
(476, 'help', 'pt', 'private-messages', 'Mensagens privadas'),
(477, 'help', 'pt', 'redirect', 'redirecionar'),
(478, 'help', 'pt', 'site', 'Site'),
(479, 'help', 'pt', 'site-modules', 'Módulos do site'),
(480, 'help', 'pt', 'smart-search', 'Busca inteligente'),
(481, 'help', 'pt', 'tags', 'Tag'),
(482, 'help', 'pt', 'templates', 'Modelos'),
(483, 'help', 'pt', 'update-sites', 'Sites de atualização'),
(484, 'help', 'pt', 'users', 'Usuários'),
(485, 'help', 'pt', 'workflow', 'fluxo de trabalho'),
(486, 'user', 'pt', 'getting-started', 'Começando'),
(487, 'user', 'pt', 'articles', 'Artigos'),
(488, 'user', 'pt', 'articles-access', 'Artigos - Acesso'),
(489, 'user', 'pt', 'articles-metadata', 'Artigos - Metadados'),
(490, 'user', 'pt', 'banners', 'Banners'),
(491, 'user', 'pt', 'command-line-interface', 'Comando'),
(492, 'user', 'pt', 'configuration', 'Configuração'),
(493, 'user', 'pt', 'contacts', 'Contatos'),
(494, 'user', 'pt', 'dashboards', 'Painéis'),
(495, 'user', 'pt', 'editors', 'Editores'),
(496, 'user', 'pt', 'extensions', 'Extensões'),
(497, 'user', 'pt', 'fields', 'Campos'),
(498, 'user', 'pt', 'help', 'Ajuda'),
(499, 'user', 'pt', 'hosting', 'Hospedagem'),
(500, 'user', 'pt', 'installation-variations', 'Variações de instalação'),
(501, 'user', 'pt', 'languages', 'línguas'),
(502, 'user', 'pt', 'media', 'meios de comunicação'),
(503, 'user', 'pt', 'menus', 'Menus'),
(504, 'user', 'pt', 'migration', 'Migração'),
(505, 'user', 'pt', 'modules', 'Módulos'),
(506, 'user', 'pt', 'news-feeds', 'Feed de notícias'),
(507, 'user', 'pt', 'performance', 'Desempenho'),
(508, 'user', 'pt', 'plugins', 'Plugins'),
(509, 'user', 'pt', 'privacy', 'Privacidade'),
(510, 'user', 'pt', 'problems', 'problemas'),
(511, 'user', 'pt', 'reference', 'Referência'),
(512, 'user', 'pt', 'security', 'Segurança'),
(513, 'user', 'pt', 'seo', 'SEO'),
(514, 'user', 'pt', 'smart-search', 'Busca inteligente'),
(515, 'user', 'pt', 'system', 'Sistema'),
(516, 'user', 'pt', 'tags', 'Tag'),
(517, 'user', 'pt', 'templates', 'Modelos'),
(518, 'user', 'pt', 'template-tips', 'Dicas de modelo'),
(519, 'user', 'pt', 'test-installations', 'Instalações de teste'),
(520, 'user', 'pt', 'users', 'Usuários'),
(521, 'user', 'pt', 'workflows', 'fluxos de trabalho'),
(522, 'developer', 'pt', 'getting-started', 'Começando'),
(523, 'developer', 'pt', 'developer-information', 'Informações do desenvolvedor'),
(524, 'developer', 'pt', 'plugin-development', 'Desenvolvimento de plug-ins'),
(525, 'developer', 'pt', 'module-development', 'Desenvolvimento de módulo'),
(526, 'developer', 'pt', 'developing-an-mvc-component', 'Desenvolvendo um componente MVC'),
(527, 'developer', 'pt', 'mvc-anatomy', 'Anatomia MVC'),
(528, 'developer', 'pt', 'mvc-examples', 'Exemplos de MVC'),
(529, 'developer', 'pt', 'cli-development', 'Desenvolvimento CLI'),
(530, 'developer', 'pt', 'database', 'Base de dados'),
(531, 'developer', 'pt', 'coding-examples', 'Exemplos de Codificação'),
(532, 'developer', 'pt', 'advanced-developer', 'Desenvolvedor Avançado'),
(533, 'developer', 'pt', 'advanced-administrator', 'Administrador Avançado'),
(534, 'developer', 'pt', 'unclassified', 'Não classificado'),
(535, 'help', 'pt-br', 'admin-modules', 'Módulos Administrativos'),
(536, 'help', 'pt-br', 'articles', 'Artigos'),
(537, 'help', 'pt-br', 'banners', 'Banners'),
(538, 'help', 'pt-br', 'cache', 'Cache'),
(539, 'help', 'pt-br', 'chunks', 'Pedaços'),
(540, 'help', 'pt-br', 'component', 'Componente'),
(541, 'help', 'pt-br', 'components', 'Componentes'),
(542, 'help', 'pt-br', 'contacts', 'Contatos'),
(543, 'help', 'pt-br', 'content-security-policy', 'Política de segurança de contato'),
(544, 'help', 'pt-br', 'editors', 'Editores'),
(545, 'help', 'pt-br', 'extensions', 'Extensões'),
(546, 'help', 'pt-br', 'fields', 'Campos'),
(547, 'help', 'pt-br', 'glossary', 'Glossário'),
(548, 'help', 'pt-br', 'help-screens', 'Telas de ajuda'),
(549, 'help', 'pt-br', 'information', 'Informações'),
(550, 'help', 'pt-br', 'install-or-update', 'Instalar ou Atualizar'),
(551, 'help', 'pt-br', 'languages', 'línguas'),
(552, 'help', 'pt-br', 'mail', 'Correspondência'),
(553, 'help', 'pt-br', 'media', 'meios de comunicação'),
(554, 'help', 'pt-br', 'menu-items', 'itens do menu'),
(555, 'help', 'pt-br', 'menus', 'Menus'),
(556, 'help', 'pt-br', 'messages', 'mensagens'),
(557, 'help', 'pt-br', 'modules', 'Módulos'),
(558, 'help', 'pt-br', 'multilingual-associations', 'Associações multilíngues'),
(559, 'help', 'pt-br', 'my-profile', 'Meu perfil'),
(560, 'help', 'pt-br', 'news-feed', 'Notícias'),
(561, 'help', 'pt-br', 'permissions', 'Permissões'),
(562, 'help', 'pt-br', 'plugins', 'Plugins'),
(563, 'help', 'pt-br', 'post-install-messages', 'Mensagens pós-instalação'),
(564, 'help', 'pt-br', 'privacy', 'Privacidade'),
(565, 'help', 'pt-br', 'private-messages', 'Mensagens privadas'),
(566, 'help', 'pt-br', 'redirect', 'redirecionar'),
(567, 'help', 'pt-br', 'site', 'Site'),
(568, 'help', 'pt-br', 'site-modules', 'Módulos do site'),
(569, 'help', 'pt-br', 'smart-search', 'Busca inteligente'),
(570, 'help', 'pt-br', 'tags', 'Tag'),
(571, 'help', 'pt-br', 'templates', 'Modelos'),
(572, 'help', 'pt-br', 'update-sites', 'Sites de atualização'),
(573, 'help', 'pt-br', 'users', 'Usuários'),
(574, 'help', 'pt-br', 'workflow', 'fluxo de trabalho'),
(575, 'user', 'pt-br', 'getting-started', 'Começando'),
(576, 'user', 'pt-br', 'articles', 'Artigos'),
(577, 'user', 'pt-br', 'articles-access', 'Artigos - Acesso'),
(578, 'user', 'pt-br', 'articles-metadata', 'Artigos - Metadados'),
(579, 'user', 'pt-br', 'banners', 'Banners'),
(580, 'user', 'pt-br', 'command-line-interface', 'Comando'),
(581, 'user', 'pt-br', 'configuration', 'Configuração'),
(582, 'user', 'pt-br', 'contacts', 'Contatos'),
(583, 'user', 'pt-br', 'dashboards', 'Painéis'),
(584, 'user', 'pt-br', 'editors', 'Editores'),
(585, 'user', 'pt-br', 'extensions', 'Extensões'),
(586, 'user', 'pt-br', 'fields', 'Campos'),
(587, 'user', 'pt-br', 'help', 'Ajuda'),
(588, 'user', 'pt-br', 'hosting', 'Hospedagem'),
(589, 'user', 'pt-br', 'installation-variations', 'Variações de instalação'),
(590, 'user', 'pt-br', 'languages', 'línguas'),
(591, 'user', 'pt-br', 'media', 'meios de comunicação'),
(592, 'user', 'pt-br', 'menus', 'Menus'),
(593, 'user', 'pt-br', 'migration', 'Migração'),
(594, 'user', 'pt-br', 'modules', 'Módulos'),
(595, 'user', 'pt-br', 'news-feeds', 'Feed de notícias'),
(596, 'user', 'pt-br', 'performance', 'Desempenho'),
(597, 'user', 'pt-br', 'plugins', 'Plugins'),
(598, 'user', 'pt-br', 'privacy', 'Privacidade'),
(599, 'user', 'pt-br', 'problems', 'problemas'),
(600, 'user', 'pt-br', 'reference', 'Referência'),
(601, 'user', 'pt-br', 'security', 'Segurança'),
(602, 'user', 'pt-br', 'seo', 'SEO'),
(603, 'user', 'pt-br', 'smart-search', 'Busca inteligente'),
(604, 'user', 'pt-br', 'system', 'Sistema'),
(605, 'user', 'pt-br', 'tags', 'Tag'),
(606, 'user', 'pt-br', 'templates', 'Modelos'),
(607, 'user', 'pt-br', 'template-tips', 'Dicas de modelo'),
(608, 'user', 'pt-br', 'test-installations', 'Instalações de teste'),
(609, 'user', 'pt-br', 'users', 'Usuários'),
(610, 'user', 'pt-br', 'workflows', 'fluxos de trabalho'),
(611, 'developer', 'pt-br', 'getting-started', 'Começando'),
(612, 'developer', 'pt-br', 'developer-information', 'Informações do desenvolvedor'),
(613, 'developer', 'pt-br', 'plugin-development', 'Desenvolvimento de plug-ins'),
(614, 'developer', 'pt-br', 'module-development', 'Desenvolvimento de módulo'),
(615, 'developer', 'pt-br', 'developing-an-mvc-component', 'Desenvolvendo um componente MVC'),
(616, 'developer', 'pt-br', 'mvc-anatomy', 'Anatomia MVC'),
(617, 'developer', 'pt-br', 'mvc-examples', 'Exemplos de MVC'),
(618, 'developer', 'pt-br', 'cli-development', 'Desenvolvimento CLI'),
(619, 'developer', 'pt-br', 'database', 'Base de dados'),
(620, 'developer', 'pt-br', 'coding-examples', 'Exemplos de Codificação'),
(621, 'developer', 'pt-br', 'advanced-developer', 'Desenvolvedor Avançado'),
(622, 'developer', 'pt-br', 'advanced-administrator', 'Administrador Avançado'),
(623, 'developer', 'pt-br', 'unclassified', 'Não classificado'),
(624, 'help', 'ru', 'admin-modules', 'Административные модули'),
(625, 'help', 'ru', 'articles', 'Статьи'),
(626, 'help', 'ru', 'banners', 'Баннеры'),
(627, 'help', 'ru', 'cache', 'Кэш'),
(628, 'help', 'ru', 'chunks', 'Куски'),
(629, 'help', 'ru', 'component', 'Компонент'),
(630, 'help', 'ru', 'components', 'Компоненты'),
(631, 'help', 'ru', 'contacts', 'Контакты'),
(632, 'help', 'ru', 'content-security-policy', 'Политика безопасности контакта'),
(633, 'help', 'ru', 'editors', 'Редакторы'),
(634, 'help', 'ru', 'extensions', 'Расширения'),
(635, 'help', 'ru', 'fields', 'Поля'),
(636, 'help', 'ru', 'glossary', 'Глоссарий'),
(637, 'help', 'ru', 'help-screens', 'Экраны справки'),
(638, 'help', 'ru', 'information', 'Информация'),
(639, 'help', 'ru', 'install-or-update', 'Установить или обновить'),
(640, 'help', 'ru', 'languages', 'Языки'),
(641, 'help', 'ru', 'mail', 'Почта'),
(642, 'help', 'ru', 'media', 'СМИ'),
(643, 'help', 'ru', 'menu-items', 'Пункты меню'),
(644, 'help', 'ru', 'menus', 'Меню'),
(645, 'help', 'ru', 'messages', 'Сообщения'),
(646, 'help', 'ru', 'modules', 'Модули'),
(647, 'help', 'ru', 'multilingual-associations', 'Многоязычные ассоциации'),
(648, 'help', 'ru', 'my-profile', 'Мой профайл'),
(649, 'help', 'ru', 'news-feed', 'Новостная лента'),
(650, 'help', 'ru', 'permissions', 'Разрешения'),
(651, 'help', 'ru', 'plugins', 'Плагины'),
(652, 'help', 'ru', 'post-install-messages', 'Сообщения после установки'),
(653, 'help', 'ru', 'privacy', 'Конфиденциальность'),
(654, 'help', 'ru', 'private-messages', 'Приватные сообщения'),
(655, 'help', 'ru', 'redirect', 'перенаправить'),
(656, 'help', 'ru', 'site', 'Сайт'),
(657, 'help', 'ru', 'site-modules', 'Модули сайта'),
(658, 'help', 'ru', 'smart-search', 'Умный поиск'),
(659, 'help', 'ru', 'tags', 'Теги'),
(660, 'help', 'ru', 'templates', 'Шаблоны'),
(661, 'help', 'ru', 'update-sites', 'Обновление сайтов'),
(662, 'help', 'ru', 'users', 'Пользователи'),
(663, 'help', 'ru', 'workflow', 'Рабочий процесс'),
(664, 'user', 'ru', 'getting-started', 'Начиная'),
(665, 'user', 'ru', 'articles', 'Статьи'),
(666, 'user', 'ru', 'articles-access', 'Статьи - Доступ'),
(667, 'user', 'ru', 'articles-metadata', 'Статьи - Метаданные'),
(668, 'user', 'ru', 'banners', 'Баннеры'),
(669, 'user', 'ru', 'command-line-interface', 'Команда'),
(670, 'user', 'ru', 'configuration', 'Конфигурация'),
(671, 'user', 'ru', 'contacts', 'Контакты'),
(672, 'user', 'ru', 'dashboards', 'Панели мониторинга'),
(673, 'user', 'ru', 'editors', 'Редакторы'),
(674, 'user', 'ru', 'extensions', 'Расширения'),
(675, 'user', 'ru', 'fields', 'Поля'),
(676, 'user', 'ru', 'help', 'Помощь'),
(677, 'user', 'ru', 'hosting', 'Хостинг'),
(678, 'user', 'ru', 'installation-variations', 'Варианты установки'),
(679, 'user', 'ru', 'languages', 'Языки'),
(680, 'user', 'ru', 'media', 'СМИ'),
(681, 'user', 'ru', 'menus', 'Меню'),
(682, 'user', 'ru', 'migration', 'Миграция'),
(683, 'user', 'ru', 'modules', 'Модули'),
(684, 'user', 'ru', 'news-feeds', 'Ленты новостей'),
(685, 'user', 'ru', 'performance', 'Производительность'),
(686, 'user', 'ru', 'plugins', 'Плагины'),
(687, 'user', 'ru', 'privacy', 'Конфиденциальность'),
(688, 'user', 'ru', 'problems', 'Проблемы'),
(689, 'user', 'ru', 'reference', 'Ссылка'),
(690, 'user', 'ru', 'security', 'Безопасность'),
(691, 'user', 'ru', 'seo', 'SEO'),
(692, 'user', 'ru', 'smart-search', 'Умный поиск'),
(693, 'user', 'ru', 'system', 'Система'),
(694, 'user', 'ru', 'tags', 'Теги'),
(695, 'user', 'ru', 'templates', 'Шаблоны'),
(696, 'user', 'ru', 'template-tips', 'Советы по шаблонам'),
(697, 'user', 'ru', 'test-installations', 'Тестовые установки'),
(698, 'user', 'ru', 'users', 'Пользователи'),
(699, 'user', 'ru', 'workflows', 'Рабочие процессы'),
(700, 'developer', 'ru', 'getting-started', 'Начиная'),
(701, 'developer', 'ru', 'developer-information', 'Информация для разработчиков'),
(702, 'developer', 'ru', 'plugin-development', 'Разработка плагинов'),
(703, 'developer', 'ru', 'module-development', 'Разработка модуля'),
(704, 'developer', 'ru', 'developing-an-mvc-component', 'Разработка компонента MVC'),
(705, 'developer', 'ru', 'mvc-anatomy', 'Анатомия MVC'),
(706, 'developer', 'ru', 'mvc-examples', 'Примеры MVC'),
(707, 'developer', 'ru', 'cli-development', 'Разработка интерфейса командной строки'),
(708, 'developer', 'ru', 'database', 'База данных'),
(709, 'developer', 'ru', 'coding-examples', 'Примеры кодирования'),
(710, 'developer', 'ru', 'advanced-developer', 'Продвинутый разработчик'),
(711, 'developer', 'ru', 'advanced-administrator', 'Расширенный администратор'),
(712, 'developer', 'ru', 'unclassified', 'Неклассифицированный'),
(713, 'help', 'en', 'guided-tours', 'Guided Tours'),
(714, 'help', 'de', 'guided-tours', 'Führungen'),
(715, 'help', 'es', 'guided-tours', 'Visitas guiadas'),
(716, 'help', 'fr', 'guided-tours', 'Visites guidées'),
(717, 'help', 'nl', 'guided-tours', 'Rondleidingen met gids'),
(718, 'help', 'pt', 'guided-tours', 'Visitas guiadas'),
(719, 'help', 'pt-br', 'guided-tours', 'Visitas guiadas'),
(720, 'help', 'ru', 'guided-tours', 'Экскурсии');

CREATE TABLE IF NOT EXISTS `#__jdocmanual_stashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `jdoc_key` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `manual` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `heading` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_title` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pr` int(11) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `commit_message` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comments` text COLLATE utf8mb4_unicode_ci,
  `markdown_text` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `page_id` (`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Introduction_to_Joomla!', 'user', 'en', 'getting-started', 'introduction-to-joomla.md', 'Introduction to Joomla!', '2023-02-09 03:58:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Core_Features', 'user', 'en', 'getting-started', 'joomla-core-features.md', 'Joomla Core Features', '2023-02-09 03:58:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Hosting_Setup', 'user', 'en', 'getting-started', 'hosting-setup.md', 'Hosting Setup', '2023-02-09 03:58:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Installing_Joomla', 'user', 'en', 'getting-started', 'installing-joomla.md', 'Installing Joomla', '2023-02-09 03:58:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Logging_in_to_Joomla', 'user', 'en', 'getting-started', 'logging-in-to-joomla.md', 'Logging in to Joomla', '2023-02-09 03:58:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Articles_and_categories', 'user', 'en', 'getting-started', 'articles-and-categories.md', 'Articles and categories', '2023-02-09 03:58:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_an_Article', 'user', 'en', 'getting-started', 'getting-started-adding-an-article.md', 'Getting Started: Adding an Article', '2023-02-09 03:58:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Category', 'user', 'en', 'getting-started', 'getting-started-adding-a-category.md', 'Getting Started: Adding a Category', '2023-02-09 03:58:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Menu_Item', 'user', 'en', 'getting-started', 'getting-started-adding-a-menu-item.md', 'Getting Started: Adding a Menu Item', '2023-02-09 03:58:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Module', 'user', 'en', 'getting-started', 'getting-started-adding-a-module.md', 'Getting Started: Adding a Module', '2023-02-09 03:58:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Site_and_Administrator_templates', 'user', 'en', 'getting-started', 'getting-started-site-and-administrator-templates.md', 'Getting Started: Site and Administrator templates', '2023-02-09 03:58:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Keyboard_Shortcuts', 'user', 'en', 'getting-started', 'keyboard-shortcuts.md', 'Keyboard Shortcuts', '2023-02-09 03:58:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Create_and_Manage_Article_Categories', 'user', 'en', 'articles', 'create-and-manage-article-categories.md', 'Create and Manage Article Categories', '2023-02-09 03:59:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Article', 'user', 'en', 'articles', 'adding-a-new-article.md', 'Adding a New Article', '2023-02-09 03:59:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Deleting_an_Article', 'user', 'en', 'articles', 'deleting-an-article.md', 'Deleting an Article', '2023-02-09 03:59:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Featured_Articles', 'user', 'en', 'articles', 'featured-articles.md', 'Featured Articles', '2023-02-09 03:59:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Archive_an_Article', 'user', 'en', 'articles', 'how-to-archive-an-article.md', 'How to Archive an Article', '2023-02-09 03:59:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Article_Headings', 'user', 'en', 'articles', 'article-headings.md', 'Article Headings', '2023-02-09 03:59:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_an_image_to_an_article', 'user', 'en', 'articles', 'adding-an-image-to-an-article.md', 'Adding an image to an article', '2023-02-09 03:59:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Article_Links', 'user', 'en', 'articles', 'article-links.md', 'Article Links', '2023-02-09 03:59:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'en', 'articles', 'adding-a-menu-link-in-an-article.md', 'Adding a menu link in an article', '2023-02-09 03:59:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Read_More_Links', 'user', 'en', 'articles', 'read-more-links.md', 'Read More Links', '2023-02-09 03:59:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Article_Lists', 'user', 'en', 'articles', 'article-lists.md', 'Article Lists', '2023-02-09 03:59:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Article_Pagination', 'user', 'en', 'articles', 'article-pagination.md', 'Article Pagination', '2023-02-09 03:59:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Article_Tables', 'user', 'en', 'articles', 'article-tables.md', 'Article Tables', '2023-02-09 03:59:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Article_Check-out_and_Check-in', 'user', 'en', 'articles-access', 'article-check-out-and-check-in.md', 'Article Check-out and Check-in', '2023-02-09 03:59:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Article_Preview', 'user', 'en', 'articles-access', 'article-preview.md', 'Article Preview', '2023-02-09 03:59:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Scheduling_the_publication_of_an_article', 'user', 'en', 'articles-access', 'scheduling-the-publication-of-an-article.md', 'Scheduling the publication of an article', '2023-02-09 03:59:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Restricting_access_to_an_Article', 'user', 'en', 'articles-access', 'restricting-access-to-an-article.md', 'Restricting access to an Article', '2023-02-09 03:59:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Restricting_access_to_read_more', 'user', 'en', 'articles-access', 'restricting-access-to-read-more.md', 'Restricting access to "read more"', '2023-02-09 03:59:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Entering_search_engine_meta-data', 'user', 'en', 'articles-metadata', 'entering-search-engine-meta-data.md', 'Entering search engine meta-data', '2023-02-09 03:59:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Meta_Description', 'user', 'en', 'articles-metadata', 'using-the-meta-description.md', 'Using The Meta Description', '2023-02-09 03:59:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Title_Tag', 'user', 'en', 'articles-metadata', 'using-the-title-tag.md', 'Using The Title Tag', '2023-02-09 03:59:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Banners', 'user', 'en', 'banners', 'banners.md', 'Banners', '2023-02-09 03:59:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Using_the_CLI', 'user', 'en', 'command-line-interface', 'using-the-cli.md', 'Using the CLI', '2023-02-09 04:00:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_CLI_Installation', 'user', 'en', 'command-line-interface', 'joomla-cli-installation.md', 'Joomla CLI Installation', '2023-02-09 04:00:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:System_Setup', 'user', 'en', 'configuration', 'system-setup.md', 'System Setup', '2023-02-09 04:00:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Global_Configuration', 'user', 'en', 'configuration', 'global-configuration.md', 'Global Configuration', '2023-02-09 04:00:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Site_Offline', 'user', 'en', 'configuration', 'site-offline.md', 'Site Offline', '2023-02-09 04:00:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_I_use_Gmail_as_my_mail_server?', 'user', 'en', 'configuration', 'how-do-i-use-gmail-as-my-mail-server-3f.md', 'How do I use Gmail as my mail server?', '2023-02-09 04:00:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_debug_SMTP_mail_in_Joomla_4', 'user', 'en', 'configuration', 'how-to-debug-smtp-mail-in-joomla-4.md', 'How to debug SMTP mail in Joomla 4', '2023-02-09 04:00:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Preconfigured_htaccess', 'user', 'en', 'configuration', 'preconfigured-htaccess.md', 'Preconfigured htaccess', '2023-02-09 04:00:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Robots.txt_file', 'user', 'en', 'configuration', 'robots-txt-file.md', 'Robots.txt file', '2023-02-09 04:00:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_www_to_a_url', 'user', 'en', 'configuration', 'adding-www-to-a-url.md', 'Adding www to a url', '2023-02-09 04:00:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_block_direct_hot_linking_to_image_files_using_htaccess?', 'user', 'en', 'configuration', 'how-do-you-block-direct-hot-linking-to-image-files-using-htaccess-3f.md', 'How do you block direct hot linking to image files using htaccess?', '2023-02-09 04:00:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_block_directory_scans_using_htaccess?', 'user', 'en', 'configuration', 'how-do-you-block-directory-scans-using-htaccess-3f.md', 'How do you block directory scans using htaccess?', '2023-02-09 04:00:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_are_the_recommended_file_and_directory_permissions?', 'user', 'en', 'configuration', 'what-are-the-recommended-file-and-directory-permissions-3f.md', 'What are the recommended file and directory permissions?', '2023-02-09 04:00:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_convert_an_htaccess.txt_file_into_a_.htaccess_file?', 'user', 'en', 'configuration', 'how-do-you-convert-an-htaccess-txt-file-into-a-htaccess-file-3f.md', 'How do you convert an htaccess.txt file into a .htaccess file?', '2023-02-09 04:00:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_password_protect_directories_using_htaccess?', 'user', 'en', 'configuration', 'how-do-you-password-protect-directories-using-htaccess-3f.md', 'How do you password protect directories using htaccess?', '2023-02-09 04:00:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Listing_a_user_on_a_contacts_page', 'user', 'en', 'contacts', 'listing-a-user-on-a-contacts-page.md', 'Listing a user on a contacts page', '2023-02-09 04:00:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_is_the_contact_creator?', 'user', 'en', 'contacts', 'what-is-the-contact-creator-3f.md', 'What is the contact creator?', '2023-02-09 04:00:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Home_Dashboard', 'user', 'en', 'dashboards', 'home-dashboard.md', 'Home Dashboard', '2023-02-09 04:00:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Content_Dashboard', 'user', 'en', 'dashboards', 'content-dashboard.md', 'Content Dashboard', '2023-02-09 04:01:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Menu_Dashboard', 'user', 'en', 'dashboards', 'menu-dashboard.md', 'Menu Dashboard', '2023-02-09 04:01:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Components_Dashboard', 'user', 'en', 'dashboards', 'components-dashboard.md', 'Components Dashboard', '2023-02-09 04:01:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Users_Dashboard', 'user', 'en', 'dashboards', 'users-dashboard.md', 'Users Dashboard', '2023-02-09 04:01:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:System_Dashboard', 'user', 'en', 'dashboards', 'system-dashboard.md', 'System Dashboard', '2023-02-09 04:01:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Help', 'user', 'en', 'dashboards', 'help.md', 'Help', '2023-02-09 04:01:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Content_editors', 'user', 'en', 'editors', 'content-editors.md', 'Content editors', '2023-02-09 04:01:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Entering_raw_HTML_in_editors', 'user', 'en', 'editors', 'entering-raw-html-in-editors.md', 'Entering raw HTML in editors', '2023-02-09 04:01:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_are_the_backgrounds_of_your_WYSIWYG_editor_fields_colored?', 'user', 'en', 'editors', 'why-are-the-backgrounds-of-your-wysiwyg-editor-fields-colored-3f.md', 'Why are the backgrounds of your WYSIWYG editor fields colored?', '2023-02-09 04:01:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_do_the_pop_ups_in_your_WYSIWYG_editor_not_work_or_show_gibberish?', 'user', 'en', 'editors', 'why-do-the-pop-ups-in-your-wysiwyg-editor-not-work-or-show-gibberish-3f.md', 'Why do the pop ups in your WYSIWYG editor not work or show gibberish?', '2023-02-09 04:01:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_place_a_copy_of_an_Excel_worksheet_on_to_your_web_site_for_viewing_only', 'user', 'en', 'editors', 'how-to-place-a-copy-of-an-excel-worksheet-on-to-your-web-site-for-viewing-only.md', 'How to place a copy of an Excel worksheet on to your web site for viewing only', '2023-02-09 04:01:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:System_Install', 'user', 'en', 'extensions', 'system-install.md', 'System Install', '2023-02-09 04:01:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Free_and_Commercial_extensions', 'user', 'en', 'extensions', 'free-and-commercial-extensions.md', 'Category:JED', '2023-02-09 04:01:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_is_a_vulnerable_extension?', 'user', 'en', 'extensions', 'what-is-a-vulnerable-extension-3f.md', 'What is a vulnerable extension?', '2023-02-09 04:01:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Where_can_you_learn_about_vulnerable_extensions?', 'user', 'en', 'extensions', 'where-can-you-learn-about-vulnerable-extensions-3f.md', 'Where can you learn about vulnerable extensions?', '2023-02-09 04:01:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_choose_secure_extensions?', 'user', 'en', 'extensions', 'how-do-you-choose-secure-extensions-3f.md', 'How do you choose secure extensions?', '2023-02-09 04:01:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_are_there_vulnerable_extensions?', 'user', 'en', 'extensions', 'why-are-there-vulnerable-extensions-3f.md', 'Why are there vulnerable extensions?', '2023-02-09 04:01:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_isn''t_un-publishing_a_vulnerable_extension_enough_to_protect_your_site?', 'user', 'en', 'extensions', 'why-isnt-un-publishing-a-vulnerable-extension-enough-to-protect-your-site-3f.md', 'Why isn''t un-publishing a vulnerable extension enough to protect your site?', '2023-02-09 04:01:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_an_extension', 'user', 'en', 'extensions', 'installing-an-extension.md', 'Installing an extension', '2023-02-09 04:01:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Fields_and_Field_Groups', 'user', 'en', 'fields', 'fields-and-field-groups.md', 'Fields and Field Groups', '2023-02-09 04:01:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Multilingual_Sites', 'user', 'en', 'fields', 'adding-custom-fields-multilingual-sites.md', 'Adding custom fields/Multilingual Sites', '2023-02-09 04:01:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Overrides', 'user', 'en', 'fields', 'adding-custom-fields-overrides.md', 'Adding custom fields/Overrides', '2023-02-09 04:02:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Parameters_for_all_Custom_Fields', 'user', 'en', 'fields', 'adding-custom-fields-parameters-for-all-custom-fields.md', 'Adding custom fields/Parameters for all Custom Fields', '2023-02-09 04:02:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/What_components_are_supporting_custom_fields', 'user', 'en', 'fields', 'adding-custom-fields-what-components-are-supporting-custom-fields.md', 'Adding custom fields/What components are supporting custom fields', '2023-02-09 04:02:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Calendar_Field', 'user', 'en', 'fields', 'adding-custom-fields-calendar-field.md', 'Adding custom fields/Calendar Field', '2023-02-09 04:02:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Checkboxes_Field', 'user', 'en', 'fields', 'adding-custom-fields-checkboxes-field.md', 'Adding custom fields/Checkboxes Field', '2023-02-09 04:02:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Color_Field', 'user', 'en', 'fields', 'adding-custom-fields-color-field.md', 'Adding custom fields/Color Field', '2023-02-09 04:02:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Editor_Field', 'user', 'en', 'fields', 'adding-custom-fields-editor-field.md', 'Adding custom fields/Editor Field', '2023-02-09 04:02:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Integer_Field', 'user', 'en', 'fields', 'adding-custom-fields-integer-field.md', 'Adding custom fields/Integer Field', '2023-02-09 04:02:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/List_Field', 'user', 'en', 'fields', 'adding-custom-fields-list-field.md', 'Adding custom fields/List Field', '2023-02-09 04:02:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/List_of_Images_Field', 'user', 'en', 'fields', 'adding-custom-fields-list-of-images-field.md', 'Adding custom fields/List of Images Field', '2023-02-09 04:02:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Media_Field', 'user', 'en', 'fields', 'adding-custom-fields-media-field.md', 'Adding custom fields/Media Field', '2023-02-09 04:02:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Radio_Field', 'user', 'en', 'fields', 'adding-custom-fields-radio-field.md', 'Adding custom fields/Radio Field', '2023-02-09 04:02:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Sql_Field', 'user', 'en', 'fields', 'adding-custom-fields-sql-field.md', 'Adding custom fields/Sql Field', '2023-02-09 04:02:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Custom_fields_type:_Subfields', 'user', 'en', 'fields', 'custom-fields-type-subfields.md', 'Custom fields type: Subfields', '2023-02-09 04:02:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Text_Field', 'user', 'en', 'fields', 'adding-custom-fields-text-field.md', 'Adding custom fields/Text Field', '2023-02-09 04:02:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Textarea_Field', 'user', 'en', 'fields', 'adding-custom-fields-textarea-field.md', 'Adding custom fields/Textarea Field', '2023-02-09 04:02:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Url_Field', 'user', 'en', 'fields', 'adding-custom-fields-url-field.md', 'Adding custom fields/Url Field', '2023-02-09 04:02:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/User_Field', 'user', 'en', 'fields', 'adding-custom-fields-user-field.md', 'Adding custom fields/User Field', '2023-02-09 04:02:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Usergroup_Field', 'user', 'en', 'fields', 'adding-custom-fields-usergroup-field.md', 'Adding custom fields/Usergroup Field', '2023-02-09 04:02:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_help_system', 'user', 'en', 'help', 'joomla-help-system.md', 'Joomla help system', '2023-02-09 04:02:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_are_help_screens?', 'user', 'en', 'help', 'what-are-help-screens-3f.md', 'What are help screens?', '2023-02-09 04:02:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Optional_Technical_Requirements', 'user', 'en', 'hosting', 'optional-technical-requirements.md', 'Optional Technical Requirements', '2023-02-09 04:02:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Hosting_Setup', 'user', 'en', 'hosting', 'hosting-setup.md', 'Hosting Setup', '2023-02-09 04:02:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Moving_the_site_among_directories/sub-directories', 'user', 'en', 'hosting', 'moving-the-site-among-directories-sub-directories.md', 'Moving the site among directories/sub-directories', '2023-02-09 04:02:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Multiple_Domains_and_Web_Sites_in_a_single_Joomla!_installation', 'user', 'en', 'hosting', 'multiple-domains-and-web-sites-in-a-single-joomla-installation.md', 'Multiple Domains and Web Sites in a single Joomla! installation', '2023-02-09 04:03:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Nginx', 'user', 'en', 'hosting', 'nginx.md', 'Nginx', '2023-02-09 04:03:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Should_PHP_run_as_a_CGI_script_or_as_an_Apache_module?', 'user', 'en', 'hosting', 'should-php-run-as-a-cgi-script-or-as-an-apache-module-3f.md', 'Should PHP run as a CGI script or as an Apache module?', '2023-02-09 04:03:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_is_the_difference_between_a_Sub-Domain,_Parked_Domain_and_an_Add-On_Domain?', 'user', 'en', 'hosting', 'what-is-the-difference-between-a-sub-domain-parked-domain-and-an-add-on-domain-3f.md', 'What is the difference between a Sub-Domain, Parked Domain and an Add-On Domain?', '2023-02-09 04:03:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_UNIX_file_permissions_work?', 'user', 'en', 'hosting', 'how-do-unix-file-permissions-work-3f.md', 'How do UNIX file permissions work?', '2023-02-09 04:03:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_Windows_file_permissions_work?', 'user', 'en', 'hosting', 'how-do-windows-file-permissions-work-3f.md', 'How do Windows file permissions work?', '2023-02-09 04:03:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_phpSuExec_file_permissions_work?', 'user', 'en', 'hosting', 'how-do-phpsuexec-file-permissions-work-3f.md', 'How do phpSuExec file permissions work?', '2023-02-09 04:03:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recursively_adjust_file_and_directory_permissions?', 'user', 'en', 'hosting', 'how-do-you-recursively-adjust-file-and-directory-permissions-3f.md', 'How do you recursively adjust file and directory permissions?', '2023-02-09 04:03:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_restrict_directory_access_by_IP_address_using_htaccess?', 'user', 'en', 'hosting', 'how-do-you-restrict-directory-access-by-ip-address-using-htaccess-3f.md', 'How do you restrict directory access by IP address using htaccess?', '2023-02-09 04:03:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_check_if_mod_rewrite_is_enabled_on_your_server', 'user', 'en', 'hosting', 'how-to-check-if-mod-rewrite-is-enabled-on-your-server.md', 'How to check if mod rewrite is enabled on your server', '2023-02-09 04:03:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_an_FTP_client_to_upload_files', 'user', 'en', 'hosting', 'using-an-ftp-client-to-upload-files.md', 'Using an FTP client to upload files', '2023-02-09 04:03:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_build_your_free_Joomla_Website', 'user', 'en', 'installation-variations', 'how-to-build-your-free-joomla-website.md', 'How to build your free Joomla Website', '2023-02-09 04:03:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('FreeBSD_Installation', 'user', 'en', 'installation-variations', 'freebsd-installation.md', 'FreeBSD Installation', '2023-02-09 04:03:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('IBM_cloud_installation', 'user', 'en', 'installation-variations', 'ibm-cloud-installation.md', 'IBM cloud installation', '2023-02-09 04:03:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('IIS', 'user', 'en', 'installation-variations', 'iis.md', 'IIS', '2023-02-09 04:03:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_Joomla!_using_BitNami_Joomla!_stack', 'user', 'en', 'installation-variations', 'installing-joomla-using-bitnami-joomla-stack.md', 'Installing Joomla! using BitNami Joomla! stack', '2023-02-09 04:03:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_Joomla_on_Debian_Linux', 'user', 'en', 'installation-variations', 'installing-joomla-on-debian-linux.md', 'Installing Joomla on Debian Linux', '2023-02-09 04:03:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_Joomla_on_a_Raspberry_Pi', 'user', 'en', 'installation-variations', 'installing-joomla-on-a-raspberry-pi.md', 'Installing Joomla on a Raspberry Pi', '2023-02-09 04:03:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_Joomla_on_a_local_web_server', 'user', 'en', 'installation-variations', 'installing-joomla-on-a-local-web-server.md', 'Installing Joomla on a local web server', '2023-02-09 04:03:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_Joomla_on_a_rented_web_server', 'user', 'en', 'installation-variations', 'installing-joomla-on-a-rented-web-server.md', 'Installing Joomla on a rented web server', '2023-02-09 04:03:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_Joomla_using_an_Auto_Installer', 'user', 'en', 'installation-variations', 'installing-joomla-using-an-auto-installer.md', 'Installing Joomla using an Auto Installer', '2023-02-09 04:03:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Setup_a_Multilingual_Site', 'user', 'en', 'languages', 'setup-a-multilingual-site.md', 'Setup a Multilingual Site', '2023-02-09 04:03:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Multilingual_Associations', 'user', 'en', 'languages', 'multilingual-associations.md', 'Multilingual Associations', '2023-02-09 04:03:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Language_Overrides', 'user', 'en', 'languages', 'language-overrides.md', 'Language Overrides', '2023-02-09 04:04:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Debugging_a_translation', 'user', 'en', 'languages', 'debugging-a-translation.md', 'Debugging a translation', '2023-02-09 04:04:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Managing_Media', 'user', 'en', 'media', 'managing-media.md', 'Managing Media', '2023-02-09 04:04:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Media:_Upload_Delete_Rename', 'user', 'en', 'media', 'media-upload-delete-rename.md', 'Media: Upload Delete Rename', '2023-02-09 04:04:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Media:_Image_Crop_Resize_Rotate', 'user', 'en', 'media', 'media-image-crop-resize-rotate.md', 'Media: Image Crop Resize Rotate', '2023-02-09 04:04:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Media:_Options', 'user', 'en', 'media', 'media-options.md', 'Media: Options', '2023-02-09 04:04:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Media:_Uploading_SVG_files', 'user', 'en', 'media', 'media-uploading-svg-files.md', 'Media: Uploading SVG files', '2023-02-09 04:04:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Menu', 'user', 'en', 'menus', 'adding-a-new-menu.md', 'Adding a New Menu', '2023-02-09 04:04:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Menu_Items', 'user', 'en', 'menus', 'menu-items.md', 'Menu Items', '2023-02-09 04:04:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Menu_Item_Types', 'user', 'en', 'menus', 'menu-item-types.md', 'Menu Item Types', '2023-02-09 04:04:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Menu_Item_Order', 'user', 'en', 'menus', 'menu-item-order.md', 'Menu Item Order', '2023-02-09 04:04:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Submenus', 'user', 'en', 'menus', 'submenus.md', 'Submenus', '2023-02-09 04:04:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Menu_Positions', 'user', 'en', 'menus', 'menu-positions.md', 'Menu Positions', '2023-02-09 04:04:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Auto_redirect_guests_to_login', 'user', 'en', 'menus', 'auto-redirect-guests-to-login.md', 'Auto redirect guests to login', '2023-02-09 04:04:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'en', 'menus', 'adding-a-menu-link-in-an-article.md', 'Adding a menu link in an article', '2023-02-09 04:04:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Create_a_Menu_Item_to_View_Archived_Articles', 'user', 'en', 'menus', 'how-to-create-a-menu-item-to-view-archived-articles.md', 'How to Create a Menu Item to View Archived Articles', '2023-02-09 04:04:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_Custom_Administrator_Menu', 'user', 'en', 'menus', 'adding-a-custom-administrator-menu.md', 'Adding a Custom Administrator Menu', '2023-02-09 04:04:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_Migrate', 'user', 'en', 'migration', 'why-migrate.md', 'Why Migrate', '2023-02-09 04:04:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_3.x_to_4.x_Step_by_Step_Migration', 'user', 'en', 'migration', 'joomla-3-x-to-4-x-step-by-step-migration.md', 'Joomla 3.x to 4.x Step by Step Migration', '2023-02-09 04:04:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Updating_from_an_existing_version', 'user', 'en', 'migration', 'updating-from-an-existing-version.md', 'Updating from an existing version', '2023-02-09 04:04:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Migration_Step_by_Step_Self_Assessment', 'user', 'en', 'migration', 'migration-step-by-step-self-assessment.md', 'Migration Step by Step Self Assessment', '2023-02-09 04:04:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Converting_an_existing_website_to_a_Joomla!_website', 'user', 'en', 'migration', 'converting-an-existing-website-to-a-joomla-website.md', 'Converting an existing website to a Joomla! website', '2023-02-09 04:04:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Update_fails_with_an_error_message', 'user', 'en', 'migration', 'update-fails-with-an-error-message.md', 'Update fails with an error message', '2023-02-09 04:04:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Updating_Joomla_(Install_Method)', 'user', 'en', 'migration', 'updating-joomla-install-method.md', 'Updating Joomla (Install Method)', '2023-02-09 04:04:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Updating_Joomla_(Update_Method)', 'user', 'en', 'migration', 'updating-joomla-update-method.md', 'Updating Joomla (Update Method)', '2023-02-09 04:04:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_Migration_-_Joomla_1.5_to_4', 'user', 'en', 'migration', 'planning-migration-joomla-1-5-to-4.md', 'Planning Migration - Joomla 1.5 to 4', '2023-02-09 04:04:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Migration', 'user', 'en', 'migration', 'planning-for-migration.md', 'Planning for Migration', '2023-02-09 04:04:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Mini-Migration_-_Joomla_3.10.x_to_4.x', 'user', 'en', 'migration', 'planning-for-mini-migration-joomla-3-10-x-to-4-x.md', 'Planning for Mini-Migration - Joomla 3.10.x to 4.x', '2023-02-09 04:05:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Potential_backward_compatibility_issues_in_Joomla_4', 'user', 'en', 'migration', 'potential-backward-compatibility-issues-in-joomla-4.md', 'Potential backward compatibility issues in Joomla 4', '2023-02-09 04:05:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Pre-Update_Check', 'user', 'en', 'migration', 'pre-update-check.md', 'Pre-Update Check', '2023-02-09 04:05:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Template_Considerations_During_Migration', 'user', 'en', 'migration', 'template-considerations-during-migration.md', 'Template Considerations During Migration', '2023-02-09 04:05:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Site_Modules', 'user', 'en', 'modules', 'site-modules.md', 'Site Modules', '2023-02-09 04:05:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Administrator_Modules', 'user', 'en', 'modules', 'administrator-modules.md', 'Administrator Modules', '2023-02-09 04:05:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Module_Positions', 'user', 'en', 'modules', 'module-positions.md', 'Module Positions', '2023-02-09 04:05:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Module_Display_by_Menu_Item', 'user', 'en', 'modules', 'module-display-by-menu-item.md', 'Module Display by Menu Item', '2023-02-09 04:05:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_put_a_module_inside_an_article?', 'user', 'en', 'modules', 'how-do-you-put-a-module-inside-an-article-3f.md', 'How do you put a module inside an article?', '2023-02-09 04:05:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_the_Login_Form_module', 'user', 'en', 'modules', 'enabling-the-login-form-module.md', 'Enabling the Login Form module', '2023-02-09 04:05:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Changing_the_Login_Form_module_settings', 'user', 'en', 'modules', 'changing-the-login-form-module-settings.md', 'Changing the Login Form module settings', '2023-02-09 04:05:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Customising_the_Login_Form_module', 'user', 'en', 'modules', 'customising-the-login-form-module.md', 'Customising the Login Form module', '2023-02-09 04:05:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Module_Class_Suffix', 'user', 'en', 'modules', 'module-class-suffix.md', 'Module Class Suffix', '2023-02-09 04:05:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Standard_Module_Chromes', 'user', 'en', 'modules', 'standard-module-chromes.md', 'Standard Module Chromes', '2023-02-09 04:05:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Show_a_Calendar_Month_List_of_Archived_Articles_Using_a_Module', 'user', 'en', 'modules', 'how-to-show-a-calendar-month-list-of-archived-articles-using-a-module.md', 'How to Show a Calendar Month List of Archived Articles Using a Module', '2023-02-09 04:05:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_create_a_custom_module?', 'user', 'en', 'modules', 'how-do-you-create-a-custom-module-3f.md', 'How do you create a custom module?', '2023-02-09 04:05:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_control_module_display_when_linking_to_an_article_with_no_menu_item', 'user', 'en', 'modules', 'how-to-control-module-display-when-linking-to-an-article-with-no-menu-item.md', 'How to control module display when linking to an article with no menu item', '2023-02-09 04:05:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_add_a_PayPal_button?', 'user', 'en', 'modules', 'how-do-you-add-a-paypal-button-3f.md', 'How do you add a PayPal button?', '2023-02-09 04:05:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_RSS_Feeds_To_Share_Content', 'user', 'en', 'news-feeds', 'using-rss-feeds-to-share-content.md', 'Using RSS Feeds To Share Content', '2023-02-09 04:05:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_display_an_RSS_feed?', 'user', 'en', 'news-feeds', 'how-do-you-display-an-rss-feed-3f.md', 'How do you display an RSS feed?', '2023-02-09 04:05:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Managing_404_Errors', 'user', 'en', 'performance', 'managing-404-errors.md', 'Managing 404 Errors', '2023-02-09 04:05:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Validating_against_accessibility_standards', 'user', 'en', 'performance', 'validating-against-accessibility-standards.md', 'Validating against accessibility standards', '2023-02-09 04:05:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Plugin_Joomla_Update_Notification', 'user', 'en', 'plugins', 'plugin-joomla-update-notification.md', 'Plugin Joomla Update Notification', '2023-02-09 04:05:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Privacy_Setup', 'user', 'en', 'privacy', 'privacy-setup.md', 'Privacy Setup', '2023-02-09 04:05:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Privacy_Workflow', 'user', 'en', 'privacy', 'privacy-workflow.md', 'Privacy Workflow', '2023-02-09 04:06:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Cookie_notification', 'user', 'en', 'privacy', 'cookie-notification.md', 'Cookie notification', '2023-02-09 04:06:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'en', 'problems', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'How do you recover or reset your admin password?', '2023-02-09 04:06:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Assorted_Issues', 'user', 'en', 'problems', 'assorted-issues.md', 'Assorted Issues', '2023-02-09 04:06:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Unsupported_PHP_Version', 'user', 'en', 'problems', 'unsupported-php-version.md', 'Unsupported PHP Version', '2023-02-09 04:06:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:FatalError', 'user', 'en', 'problems', 'fatalerror.md', 'FatalError', '2023-02-09 04:06:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Help', 'user', 'en', 'problems', 'help.md', 'Help', '2023-02-09 04:06:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Get_locally_hosted_Joomla!_website_e-mail_functions_to_work', 'user', 'en', 'problems', 'get-locally-hosted-joomla-website-e-mail-functions-to-work.md', 'Get locally hosted Joomla! website e-mail functions to work', '2023-02-09 04:06:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_and_MySQL_8', 'user', 'en', 'problems', 'joomla-and-mysql-8.md', 'Joomla and MySQL 8', '2023-02-09 04:06:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Please_first_make_a_selection_from_the_list', 'user', 'en', 'problems', 'please-first-make-a-selection-from-the-list.md', 'Please first make a selection from the list', '2023-02-09 04:06:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Unable_to_connect_to_the_database', 'user', 'en', 'problems', 'unable-to-connect-to-the-database.md', 'Unable to connect to the database', '2023-02-09 04:06:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Update_did_not_finish_successfully', 'user', 'en', 'problems', 'update-did-not-finish-successfully.md', 'Update did not finish successfully', '2023-02-09 04:06:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_Licenses', 'user', 'en', 'reference', 'joomla-licenses.md', 'Joomla Licenses', '2023-02-09 04:06:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_has_the_copyright_of_Joomla!?', 'user', 'en', 'reference', 'what-has-the-copyright-of-joomla-3f.md', 'What has the copyright of Joomla!?', '2023-02-09 04:06:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_license_is_Joomla!_released_under?', 'user', 'en', 'reference', 'what-license-is-joomla-released-under-3f.md', 'What license is Joomla! released under?', '2023-02-09 04:06:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_are_web_standards?', 'user', 'en', 'reference', 'what-are-web-standards-3f.md', 'What are web standards?', '2023-02-09 04:06:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Where_are_the_web_pages?', 'user', 'en', 'reference', 'where-are-the-web-pages-3f.md', 'Where are the web pages?', '2023-02-09 04:06:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_is_the_Joomla!_Administrator''s_Security_Checklist?', 'user', 'en', 'security', 'what-is-the-joomla-administrators-security-checklist-3f.md', 'What is the Joomla! Administrator''s Security Checklist?', '2023-02-09 04:06:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_HTTPS_on_your_site', 'user', 'en', 'security', 'enabling-https-on-your-site.md', 'Enabling HTTPS on your site', '2023-02-09 04:06:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Htaccess_examples_(security)', 'user', 'en', 'security', 'htaccess-examples-security.md', 'Htaccess examples (security)', '2023-02-09 04:06:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Getting_Started', 'user', 'en', 'security', 'security-checklist-getting-started.md', 'Security Checklist/Getting Started', '2023-02-09 04:06:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Hosting_and_Server_Setup', 'user', 'en', 'security', 'security-checklist-hosting-and-server-setup.md', 'Security Checklist/Hosting and Server Setup', '2023-02-09 04:07:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Where_can_you_learn_more_about_file_permissions?', 'user', 'en', 'security', 'security-checklist-where-can-you-learn-more-about-file-permissions-3f.md', 'Security Checklist/Where can you learn more about file permissions?', '2023-02-09 04:07:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Testing_and_Development', 'user', 'en', 'security', 'security-checklist-testing-and-development.md', 'Security Checklist/Testing and Development', '2023-02-09 04:07:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Joomla!_Setup', 'user', 'en', 'security', 'security-checklist-joomla-setup.md', 'Security Checklist/Joomla! Setup', '2023-02-09 04:07:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Site_Administration', 'user', 'en', 'security', 'security-checklist-site-administration.md', 'Security Checklist/Site Administration', '2023-02-09 04:07:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Site_Recovery', 'user', 'en', 'security', 'security-checklist-site-recovery.md', 'Security Checklist/Site Recovery', '2023-02-09 04:07:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/You_have_been_hacked_or_defaced', 'user', 'en', 'security', 'security-checklist-you-have-been-hacked-or-defaced.md', 'Security Checklist/You have been hacked or defaced', '2023-02-09 04:07:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_-_Before_you_go_live', 'user', 'en', 'security', 'security-before-you-go-live.md', 'Security - Before you go live', '2023-02-09 04:07:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_FAQ', 'user', 'en', 'security', 'security-faq.md', 'Security FAQ', '2023-02-09 04:07:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_and_Performance_FAQs', 'user', 'en', 'security', 'security-and-performance-faqs.md', 'Security and Performance FAQs', '2023-02-09 04:07:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_filters_for_articles', 'user', 'en', 'security', 'security-filters-for-articles.md', 'Security filters for articles', '2023-02-09 04:07:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Securing_Joomla_extensions', 'user', 'en', 'security', 'securing-joomla-extensions.md', 'Securing Joomla extensions', '2023-02-09 04:07:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_is_Search_Engine_Optimisation', 'user', 'en', 'seo', 'what-is-search-engine-optimisation.md', 'What is Search Engine Optimisation', '2023-02-09 04:07:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Making_your_site_Search_Engine_Friendly', 'user', 'en', 'seo', 'making-your-site-search-engine-friendly.md', 'Making your site Search Engine Friendly', '2023-02-09 04:07:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Search_Engine_Friendly_URLs', 'user', 'en', 'seo', 'search-engine-friendly-urls.md', 'Search Engine Friendly URLs', '2023-02-09 04:07:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_A_Sitemap', 'user', 'en', 'seo', 'using-a-sitemap.md', 'Using A Sitemap', '2023-02-09 04:07:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Title_Tag', 'user', 'en', 'seo', 'using-the-title-tag.md', 'Using The Title Tag', '2023-02-09 04:07:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Meta_Description', 'user', 'en', 'seo', 'using-the-meta-description.md', 'Using The Meta Description', '2023-02-09 04:07:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_Keywords', 'user', 'en', 'seo', 'using-keywords.md', 'Using Keywords', '2023-02-09 04:07:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Semantic_HTML_Markup', 'user', 'en', 'seo', 'semantic-html-markup.md', 'Semantic HTML Markup', '2023-02-09 04:07:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Linking_To_Other_Sites', 'user', 'en', 'seo', 'linking-to-other-sites.md', 'Linking To Other Sites', '2023-02-09 04:07:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Important_SEO_Points_To_Remember', 'user', 'en', 'seo', 'important-seo-points-to-remember.md', 'Important SEO Points To Remember', '2023-02-09 04:07:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Monitoring_SEO', 'user', 'en', 'seo', 'monitoring-seo.md', 'Monitoring SEO', '2023-02-09 04:07:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Common_problems_when_enabling_Search_Engine_Friendly_(SEF)_URLs', 'user', 'en', 'seo', 'common-problems-when-enabling-search-engine-friendly-sef-urls.md', 'Common problems when enabling Search Engine Friendly (SEF) URLs', '2023-02-09 04:08:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs', 'user', 'en', 'seo', 'enabling-search-engine-friendly-sef-urls.md', 'Enabling Search Engine Friendly (SEF) URLs', '2023-02-09 04:08:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Apache', 'user', 'en', 'seo', 'enabling-search-engine-friendly-sef-urls-on-apache.md', 'Enabling Search Engine Friendly (SEF) URLs on Apache', '2023-02-09 04:08:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Hiawatha', 'user', 'en', 'seo', 'enabling-search-engine-friendly-sef-urls-on-hiawatha.md', 'Enabling Search Engine Friendly (SEF) URLs on Hiawatha', '2023-02-09 04:08:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_IIS', 'user', 'en', 'seo', 'enabling-search-engine-friendly-sef-urls-on-iis.md', 'Enabling Search Engine Friendly (SEF) URLs on IIS', '2023-02-09 04:08:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_IIS/IIS6', 'user', 'en', 'seo', 'enabling-search-engine-friendly-sef-urls-on-iis-iis6.md', 'Enabling Search Engine Friendly (SEF) URLs on IIS/IIS6', '2023-02-09 04:08:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_IIS/IIS6/1.0', 'user', 'en', 'seo', 'enabling-search-engine-friendly-sef-urls-on-iis-iis6-1-0.md', 'Enabling Search Engine Friendly (SEF) URLs on IIS/IIS6/1.0', '2023-02-09 04:08:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_IIS/IIS6/1.5', 'user', 'en', 'seo', 'enabling-search-engine-friendly-sef-urls-on-iis-iis6-1-5.md', 'Enabling Search Engine Friendly (SEF) URLs on IIS/IIS6/1.5', '2023-02-09 04:08:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_IIS/IIS7', 'user', 'en', 'seo', 'enabling-search-engine-friendly-sef-urls-on-iis-iis7.md', 'Enabling Search Engine Friendly (SEF) URLs on IIS/IIS7', '2023-02-09 04:08:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Nginx', 'user', 'en', 'seo', 'enabling-search-engine-friendly-sef-urls-on-nginx.md', 'Enabling Search Engine Friendly (SEF) URLs on Nginx', '2023-02-09 04:08:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Smart_Search_quickstart_guide', 'user', 'en', 'smart-search', 'smart-search-quickstart-guide.md', 'Smart Search quickstart guide', '2023-02-09 04:08:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Smart_Search_on_large_sites', 'user', 'en', 'smart-search', 'smart-search-on-large-sites.md', 'Smart Search on large sites', '2023-02-09 04:08:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Customising_the_Smart_Search_results_page', 'user', 'en', 'smart-search', 'customising-the-smart-search-results-page.md', 'Customising the Smart Search results page', '2023-02-09 04:08:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Setting_up_automatic_Smart_Search_indexing', 'user', 'en', 'smart-search', 'setting-up-automatic-smart-search-indexing.md', 'Setting up automatic Smart Search indexing', '2023-02-09 04:08:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Smart_Search_Frequently_Asked_Questions', 'user', 'en', 'smart-search', 'smart-search-frequently-asked-questions.md', 'Smart Search Frequently Asked Questions', '2023-02-09 04:08:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Smart_Search_configuration_options', 'user', 'en', 'smart-search', 'smart-search-configuration-options.md', 'Smart Search configuration options', '2023-02-09 04:08:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Smart_Search_content_change_test_plan', 'user', 'en', 'smart-search', 'smart-search-content-change-test-plan.md', 'Smart Search content change test plan', '2023-02-09 04:08:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Cache', 'user', 'en', 'system', 'cache.md', 'Cache', '2023-02-09 04:08:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Backup_Basics_for_a_Joomla!_Web_Site', 'user', 'en', 'system', 'backup-basics-for-a-joomla-web-site.md', 'Backup Basics for a Joomla! Web Site', '2023-02-09 04:08:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_are_the_best_practices_for_site_backups?', 'user', 'en', 'system', 'what-are-the-best-practices-for-site-backups-3f.md', 'What are the best practices for site backups?', '2023-02-09 04:08:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Copying_a_Joomla_website', 'user', 'en', 'system', 'copying-a-joomla-website.md', 'Copying a Joomla website', '2023-02-09 04:08:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Copying_a_website_from_localhost_to_a_remote_host', 'user', 'en', 'system', 'copying-a-website-from-localhost-to-a-remote-host.md', 'Copying a website from localhost to a remote host', '2023-02-09 04:09:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Database_Table_Prefix', 'user', 'en', 'system', 'database-table-prefix.md', 'Database Table Prefix', '2023-02-09 04:09:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Monitoring_Server_Health', 'user', 'en', 'system', 'monitoring-server-health.md', 'Monitoring Server Health', '2023-02-09 04:09:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Monitoring_Site_Speed', 'user', 'en', 'system', 'monitoring-site-speed.md', 'Monitoring Site Speed', '2023-02-09 04:09:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('One_click_updates_for_language_packs', 'user', 'en', 'system', 'one-click-updates-for-language-packs.md', 'One click updates for language packs', '2023-02-09 04:09:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Purging_expired_cache_files', 'user', 'en', 'system', 'purging-expired-cache-files.md', 'Purging expired cache files', '2023-02-09 04:09:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Top_10_Stupidest_Administrator_Tricks', 'user', 'en', 'system', 'top-10-stupidest-administrator-tricks.md', 'Top 10 Stupidest Administrator Tricks', '2023-02-09 04:09:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Updating_PHP', 'user', 'en', 'system', 'updating-php.md', 'Updating PHP', '2023-02-09 04:09:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Task_Scheduler', 'user', 'en', 'system', 'task-scheduler.md', 'Task Scheduler', '2023-02-09 04:09:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Uploading_and_extracting_an_archive_file_with_CPanel', 'user', 'en', 'system', 'uploading-and-extracting-an-archive-file-with-cpanel.md', 'Uploading and extracting an archive file with CPanel', '2023-02-09 04:09:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_Caching_to_Speed_Up_Your_Code', 'user', 'en', 'system', 'using-caching-to-speed-up-your-code.md', 'Using Caching to Speed Up Your Code', '2023-02-09 04:09:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_To_Use_Content_Tags_in_Joomla', 'user', 'en', 'tags', 'how-to-use-content-tags-in-joomla.md', 'How To Use Content Tags in Joomla', '2023-02-09 04:09:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Template_Basics', 'user', 'en', 'templates', 'template-basics.md', 'Template Basics', '2023-02-09 04:09:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Cassiopeia_Template_Customisation', 'user', 'en', 'templates', 'cassiopeia-template-customisation.md', 'Cassiopeia Template Customisation', '2023-02-09 04:09:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Template_Overrides', 'user', 'en', 'templates', 'template-overrides.md', 'Template Overrides', '2023-02-09 04:09:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Template_Layouts', 'user', 'en', 'templates', 'template-layouts.md', 'Template Layouts', '2023-02-09 04:09:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Child_Templates', 'user', 'en', 'templates', 'child-templates.md', 'Child Templates', '2023-02-09 04:09:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Favicons', 'user', 'en', 'templates', 'favicons.md', 'Favicons', '2023-02-09 04:09:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Template_SVG_Logos', 'user', 'en', 'templates', 'template-svg-logos.md', 'Template SVG Logos', '2023-02-09 04:09:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Cassiopeia_templateDetails.xml', 'user', 'en', 'templates', 'cassiopeia-templatedetails-xml.md', 'Cassiopeia templateDetails.xml', '2023-02-09 04:09:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Switching_Templates', 'user', 'en', 'template-tips', 'switching-templates.md', 'Switching Templates', '2023-02-09 04:09:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Home_Page_in_Different_Style', 'user', 'en', 'template-tips', 'home-page-in-different-style.md', 'Home Page in Different Style', '2023-02-09 04:09:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Module_and_Menu_Styles', 'user', 'en', 'template-tips', 'module-and-menu-styles.md', 'Module and Menu Styles', '2023-02-09 04:09:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Standard_Font_Awesome_Fonts', 'user', 'en', 'template-tips', 'joomla-standard-font-awesome-fonts.md', 'Joomla Standard Font Awesome Fonts', '2023-02-09 04:10:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Visual_Studio_Code_Primer', 'user', 'en', 'test-installations', 'visual-studio-code-primer.md', 'Visual Studio Code Primer', '2023-02-09 04:10:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Visual_Studio_Code', 'user', 'en', 'test-installations', 'visual-studio-code.md', 'Visual Studio Code', '2023-02-09 04:10:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Setting_up_Apache,_PHP_and_MySQL_manually', 'user', 'en', 'test-installations', 'setting-up-apache-php-and-mysql-manually.md', 'Setting up Apache, PHP and MySQL manually', '2023-02-09 04:10:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Verifying_permissions', 'user', 'en', 'test-installations', 'verifying-permissions.md', 'Verifying permissions', '2023-02-09 04:10:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Web_page_diagnostic_tools', 'user', 'en', 'test-installations', 'web-page-diagnostic-tools.md', 'Web page diagnostic tools', '2023-02-09 04:10:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Access_Control', 'user', 'en', 'users', 'access-control.md', 'Access Control', '2023-02-09 04:10:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:User_Registration', 'user', 'en', 'users', 'user-registration.md', 'User Registration', '2023-02-09 04:10:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:User_Profile', 'user', 'en', 'users', 'user-profile.md', 'User Profile', '2023-02-09 04:10:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:User_Password_Reset', 'user', 'en', 'users', 'user-password-reset.md', 'User Password Reset', '2023-02-09 04:10:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('WebAuthn_Passwordless_Login', 'user', 'en', 'users', 'webauthn-passwordless-login.md', 'WebAuthn Passwordless Login', '2023-02-09 04:10:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Multi-factor_Authentication', 'user', 'en', 'users', 'multi-factor-authentication.md', 'Multi-factor Authentication', '2023-02-09 04:10:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'en', 'users', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'How do you recover or reset your admin password?', '2023-02-09 04:10:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Guest_Access', 'user', 'en', 'users', 'guest-access.md', 'Guest Access', '2023-02-09 04:10:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Changing_user_groups', 'user', 'en', 'users', 'changing-user-groups.md', 'Changing user groups', '2023-02-09 04:10:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Login_and_Logout_Redirects', 'user', 'en', 'users', 'login-and-logout-redirects.md', 'Login and Logout Redirects', '2023-02-09 04:10:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_can''t_a_user_see_anything_on_the_backend?', 'user', 'en', 'users', 'why-cant-a-user-see-anything-on-the-backend-3f.md', 'Why can''t a user see anything on the backend?', '2023-02-09 04:10:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:User_Actions_Log', 'user', 'en', 'users', 'user-actions-log.md', 'User Actions Log', '2023-02-09 04:10:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Workflow', 'user', 'en', 'workflows', 'workflow.md', 'Workflow', '2023-02-09 04:11:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Workflow/Scenarios', 'user', 'en', 'workflows', 'workflow-scenarios.md', 'Workflow/Scenarios', '2023-02-09 04:11:04') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Article', 'user', 'de', 'getting-started', 'adding-a-new-article.md', 'Einen neuen Beitrag hinzufügen', '2023-02-11 12:14:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Installing_Joomla', 'user', 'de', 'getting-started', 'installing-joomla.md', 'Joomla! installieren', '2023-02-11 12:15:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Logging_in_to_Joomla', 'user', 'de', 'getting-started', 'logging-in-to-joomla.md', 'Einloggen in Joomla', '2023-02-11 12:15:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_an_Article', 'user', 'de', 'getting-started', 'getting-started-adding-an-article.md', 'Erste Schritte: Einen Beitrag hinzufügen', '2023-02-11 12:15:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Category', 'user', 'de', 'getting-started', 'getting-started-adding-a-category.md', 'Erste Schritte: Eine Kategorie hinzufügen', '2023-02-11 12:15:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Menu_Item', 'user', 'de', 'getting-started', 'getting-started-adding-a-menu-item.md', 'Erste Schritte: Einen Menüpunkt hinzufügen', '2023-02-11 12:15:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Module', 'user', 'de', 'getting-started', 'getting-started-adding-a-module.md', 'Erste Schritte: Ein Modul hinzufügen', '2023-02-11 12:15:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Site_and_Administrator_templates', 'user', 'de', 'getting-started', 'getting-started-site-and-administrator-templates.md', 'Erste Schritte: Site- und Administrator-Templates', '2023-02-11 12:15:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Create_and_Manage_Article_Categories', 'user', 'de', 'articles', 'create-and-manage-article-categories.md', 'Beitragskategorien erstellen und verwalten', '2023-02-11 12:15:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Article', 'user', 'de', 'articles', 'adding-a-new-article.md', 'Einen neuen Beitrag hinzufügen', '2023-02-11 12:15:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Deleting_an_Article', 'user', 'de', 'articles', 'deleting-an-article.md', 'Beitrag löschen', '2023-02-11 12:15:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Archive_an_Article', 'user', 'de', 'articles', 'how-to-archive-an-article.md', 'Beitrag archivieren', '2023-02-11 12:15:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_an_image_to_an_article', 'user', 'de', 'articles', 'adding-an-image-to-an-article.md', 'Ein Bild in einen Beitrag einfügen', '2023-02-11 12:15:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'de', 'articles', 'adding-a-menu-link-in-an-article.md', 'Einem Beitrag einen Menülink hinzufügen', '2023-02-11 12:15:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Meta_Description', 'user', 'de', 'articles-metadata', 'using-the-meta-description.md', 'Die Meta-Beschreibung verwenden', '2023-02-11 12:15:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Title_Tag', 'user', 'de', 'articles-metadata', 'using-the-title-tag.md', 'Den Titel-Tag verwenden', '2023-02-11 12:15:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_www_to_a_url', 'user', 'de', 'configuration', 'adding-www-to-a-url.md', 'Hinzufügen von www zu einer URL', '2023-02-11 12:16:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_block_directory_scans_using_htaccess?', 'user', 'de', 'configuration', 'how-do-you-block-directory-scans-using-htaccess-3f.md', 'Ordnerscans mit htaccess blockieren', '2023-02-11 12:16:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_convert_an_htaccess.txt_file_into_a_.htaccess_file?', 'user', 'de', 'configuration', 'how-do-you-convert-an-htaccess-txt-file-into-a-htaccess-file-3f.md', 'Wie wird die htaccess.txt in eine .htaccess-Datei konvertiert?', '2023-02-11 12:16:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Menu_Dashboard', 'user', 'de', 'dashboards', 'menu-dashboard.md', 'Dashboard-Menü', '2023-02-11 12:16:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Content_editors', 'user', 'de', 'editors', 'content-editors.md', 'Standard-Editoren', '2023-02-11 12:16:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_is_a_vulnerable_extension?', 'user', 'de', 'extensions', 'what-is-a-vulnerable-extension-3f.md', 'Was ist eine gefährliche Erweiterung?', '2023-02-11 12:16:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_choose_secure_extensions?', 'user', 'de', 'extensions', 'how-do-you-choose-secure-extensions-3f.md', 'Wie wählt man sichere Erweiterungen aus?', '2023-02-11 12:16:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_an_extension', 'user', 'de', 'extensions', 'installing-an-extension.md', 'Installation einer Erweiterung', '2023-02-11 12:16:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Overrides', 'user', 'de', 'fields', 'adding-custom-fields-overrides.md', 'Anwendung von Feldern / Overrides', '2023-02-11 12:17:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Parameters_for_all_Custom_Fields', 'user', 'de', 'fields', 'adding-custom-fields-parameters-for-all-custom-fields.md', 'Hinzufügen von Feldern/ Parametern für Felder', '2023-02-11 12:17:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/What_components_are_supporting_custom_fields', 'user', 'de', 'fields', 'adding-custom-fields-what-components-are-supporting-custom-fields.md', 'Welche Komponenten unterstützen die Felder', '2023-02-11 12:17:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Calendar_Field', 'user', 'de', 'fields', 'adding-custom-fields-calendar-field.md', 'Anwendung von Eigene Felder / Kalender-Feld', '2023-02-11 12:17:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Checkboxes_Field', 'user', 'de', 'fields', 'adding-custom-fields-checkboxes-field.md', 'Kontrollkästchen-Feld', '2023-02-11 12:17:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Color_Field', 'user', 'de', 'fields', 'adding-custom-fields-color-field.md', 'Farbe-Feld', '2023-02-11 12:17:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Editor_Field', 'user', 'de', 'fields', 'adding-custom-fields-editor-field.md', 'Editor-Feld', '2023-02-11 12:17:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Integer_Field', 'user', 'de', 'fields', 'adding-custom-fields-integer-field.md', 'Feld für natürliche Zahlen', '2023-02-11 12:17:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/List_Field', 'user', 'de', 'fields', 'adding-custom-fields-list-field.md', 'Listen-Feld', '2023-02-11 12:17:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/List_of_Images_Field', 'user', 'de', 'fields', 'adding-custom-fields-list-of-images-field.md', 'Bilder-Listen Feld', '2023-02-11 12:17:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Media_Field', 'user', 'de', 'fields', 'adding-custom-fields-media-field.md', 'Anwendung von Eigene Felder / Medien-Feld', '2023-02-11 12:17:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Radio_Field', 'user', 'de', 'fields', 'adding-custom-fields-radio-field.md', 'Optionsfeld (radio)', '2023-02-11 12:17:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Sql_Field', 'user', 'de', 'fields', 'adding-custom-fields-sql-field.md', 'SQL-Feld', '2023-02-11 12:17:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Text_Field', 'user', 'de', 'fields', 'adding-custom-fields-text-field.md', 'Textfeld', '2023-02-11 12:17:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Textarea_Field', 'user', 'de', 'fields', 'adding-custom-fields-textarea-field.md', 'Textbereich Feld', '2023-02-11 12:17:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Url_Field', 'user', 'de', 'fields', 'adding-custom-fields-url-field.md', 'URL-Feld', '2023-02-11 12:17:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/User_Field', 'user', 'de', 'fields', 'adding-custom-fields-user-field.md', 'Benutzer Feld', '2023-02-11 12:17:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Usergroup_Field', 'user', 'de', 'fields', 'adding-custom-fields-usergroup-field.md', 'Benutzergruppe Feld', '2023-02-11 12:17:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Optional_Technical_Requirements', 'user', 'de', 'hosting', 'optional-technical-requirements.md', 'Optionale technische Voraussetzungen', '2023-02-11 12:17:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Nginx', 'user', 'de', 'hosting', 'nginx.md', 'Nginx', '2023-02-11 12:17:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_check_if_mod_rewrite_is_enabled_on_your_server', 'user', 'de', 'hosting', 'how-to-check-if-mod-rewrite-is-enabled-on-your-server.md', 'Prüfen, ob "mod_rewrite" am Server aktiviert ist', '2023-02-11 12:18:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_an_FTP_client_to_upload_files', 'user', 'de', 'hosting', 'using-an-ftp-client-to-upload-files.md', 'Ein FTP-Programm zum Hochladen von Dateien verwenden', '2023-02-11 12:18:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_build_your_free_Joomla_Website', 'user', 'de', 'installation-variations', 'how-to-build-your-free-joomla-website.md', 'Wie kann eine kostenlose Joomla-Webseite erstellt werden?', '2023-02-11 12:18:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('FreeBSD_Installation', 'user', 'de', 'installation-variations', 'freebsd-installation.md', 'FreeBSD-Installation', '2023-02-11 12:18:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Managing_Media', 'user', 'de', 'media', 'managing-media.md', 'Medien verwalten', '2023-02-11 12:18:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Media:_Options', 'user', 'de', 'media', 'media-options.md', 'Medien: Optionen', '2023-02-11 12:18:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Menu', 'user', 'de', 'menus', 'adding-a-new-menu.md', 'Ein neues Menü hinzufügen', '2023-02-11 12:18:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'de', 'menus', 'adding-a-menu-link-in-an-article.md', 'Einem Beitrag einen Menülink hinzufügen', '2023-02-11 12:18:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Create_a_Menu_Item_to_View_Archived_Articles', 'user', 'de', 'menus', 'how-to-create-a-menu-item-to-view-archived-articles.md', 'How to Create a Menu Item to View Archived Articles', '2023-02-11 12:18:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_Migrate', 'user', 'de', 'migration', 'why-migrate.md', 'Warum migrieren', '2023-02-11 12:18:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_3.x_to_4.x_Step_by_Step_Migration', 'user', 'de', 'migration', 'joomla-3-x-to-4-x-step-by-step-migration.md', 'Joomla! 3.x nach 4.x: Migration - Schritt für Schritt', '2023-02-11 12:18:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Updating_from_an_existing_version', 'user', 'de', 'migration', 'updating-from-an-existing-version.md', 'Updating from an existing version', '2023-02-11 12:18:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Migration_Step_by_Step_Self_Assessment', 'user', 'de', 'migration', 'migration-step-by-step-self-assessment.md', 'Migration Schritt für Schritt - Selbsteinschätzung', '2023-02-11 12:18:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Update_fails_with_an_error_message', 'user', 'de', 'migration', 'update-fails-with-an-error-message.md', 'Update schlägt mit einer Fehlermeldung fehl', '2023-02-11 12:18:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Updating_Joomla_(Update_Method)', 'user', 'de', 'migration', 'updating-joomla-update-method.md', 'Aktualisierung von Joomla! (Update-Methode)', '2023-02-11 12:18:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_Migration_-_Joomla_1.5_to_4', 'user', 'de', 'migration', 'planning-migration-joomla-1-5-to-4.md', 'Planung der Migration von Joomla! 1.5 nach 4', '2023-02-11 12:18:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Migration', 'user', 'de', 'migration', 'planning-for-migration.md', 'Planung der Migration', '2023-02-11 12:19:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Mini-Migration_-_Joomla_3.10.x_to_4.x', 'user', 'de', 'migration', 'planning-for-mini-migration-joomla-3-10-x-to-4-x.md', 'Planung einer Mini-Migration - Joomla 3.10.x nach 4.x', '2023-02-11 12:19:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Potential_backward_compatibility_issues_in_Joomla_4', 'user', 'de', 'migration', 'potential-backward-compatibility-issues-in-joomla-4.md', 'Rückwärtskompatibilität: Mögliche Probleme in Joomla 4', '2023-02-11 12:19:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Pre-Update_Check', 'user', 'de', 'migration', 'pre-update-check.md', 'Kompatibilitätsprüfung (Pre-Update Check)', '2023-02-11 12:19:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Template_Considerations_During_Migration', 'user', 'de', 'migration', 'template-considerations-during-migration.md', 'Überlegungen zum Template bei der Migration', '2023-02-11 12:19:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_put_a_module_inside_an_article?', 'user', 'de', 'modules', 'how-do-you-put-a-module-inside-an-article-3f.md', 'Wie kann man ein Modul in den Inhalt eines Beitrags setzen?', '2023-02-11 12:19:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_the_Login_Form_module', 'user', 'de', 'modules', 'enabling-the-login-form-module.md', 'Das Modul "Anmeldung" veröffentlichen', '2023-02-11 12:19:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Changing_the_Login_Form_module_settings', 'user', 'de', 'modules', 'changing-the-login-form-module-settings.md', 'Modul "Anmeldeformular" anpassen', '2023-02-11 12:19:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Customising_the_Login_Form_module', 'user', 'de', 'modules', 'customising-the-login-form-module.md', 'Das Modul "Anmeldeformular" anpassen', '2023-02-11 12:19:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Module_Class_Suffix', 'user', 'de', 'modules', 'module-class-suffix.md', 'Modul-Klassen-Suffix', '2023-02-11 12:19:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Standard_Module_Chromes', 'user', 'de', 'modules', 'standard-module-chromes.md', 'Standard Modul Chromes', '2023-02-11 12:19:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Show_a_Calendar_Month_List_of_Archived_Articles_Using_a_Module', 'user', 'de', 'modules', 'how-to-show-a-calendar-month-list-of-archived-articles-using-a-module.md', 'Eine nach Kalendermonaten sortierte Liste mit einem eigenen Modul anzeigen', '2023-02-11 12:19:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_add_a_PayPal_button?', 'user', 'de', 'modules', 'how-do-you-add-a-paypal-button-3f.md', 'Wie kann man einen PayPal-Button hinzufügen?', '2023-02-11 12:19:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Validating_against_accessibility_standards', 'user', 'de', 'performance', 'validating-against-accessibility-standards.md', 'Prüfung der Barrierefreiheit', '2023-02-11 12:19:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'de', 'problems', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'Wie kann das Administrator Passwort wieder hergestellt oder zurückgesetzt werden?', '2023-02-11 12:19:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_and_MySQL_8', 'user', 'de', 'problems', 'joomla-and-mysql-8.md', 'Joomla und MySQL 8', '2023-02-11 12:19:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_HTTPS_on_your_site', 'user', 'de', 'security', 'enabling-https-on-your-site.md', 'HTTPS der Webseite aktivieren', '2023-02-11 12:20:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Getting_Started', 'user', 'de', 'security', 'security-checklist-getting-started.md', 'Sicherheits-Checkliste / Erste Schritte', '2023-02-11 12:20:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Hosting_and_Server_Setup', 'user', 'de', 'security', 'security-checklist-hosting-and-server-setup.md', 'Sicherheits-Checkliste / Einrichtung von Hosting und Server', '2023-02-11 12:20:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Where_can_you_learn_more_about_file_permissions?', 'user', 'de', 'security', 'security-checklist-where-can-you-learn-more-about-file-permissions-3f.md', 'Sicherheits-Checkliste / Wo kann ich mehr über Datei-Berechtigungen lernen?', '2023-02-11 12:20:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Testing_and_Development', 'user', 'de', 'security', 'security-checklist-testing-and-development.md', 'Sicherheits-Checkliste / Testen und Entwicklung', '2023-02-11 12:20:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Joomla!_Setup', 'user', 'de', 'security', 'security-checklist-joomla-setup.md', 'Sicherheits-Checkliste / Einrichtung von Joomla!', '2023-02-11 12:20:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Site_Administration', 'user', 'de', 'security', 'security-checklist-site-administration.md', 'Sicherheits-Checkliste / Administration der Webseite', '2023-02-11 12:20:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Site_Recovery', 'user', 'de', 'security', 'security-checklist-site-recovery.md', 'Security Checklist / Wiederherstellung der Webseite', '2023-02-11 12:20:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/You_have_been_hacked_or_defaced', 'user', 'de', 'security', 'security-checklist-you-have-been-hacked-or-defaced.md', 'Sicherheits-Checkliste / Webseite wurde gehackt oder verändert', '2023-02-11 12:20:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Securing_Joomla_extensions', 'user', 'de', 'security', 'securing-joomla-extensions.md', 'Joomla-Erweiterungen absichern', '2023-02-11 12:20:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Making_your_site_Search_Engine_Friendly', 'user', 'de', 'seo', 'making-your-site-search-engine-friendly.md', 'Die Website suchmaschinenfreundlich gestalten', '2023-02-11 12:20:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Search_Engine_Friendly_URLs', 'user', 'de', 'seo', 'search-engine-friendly-urls.md', 'Suchmaschinenfreundliche URLs', '2023-02-11 12:20:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_A_Sitemap', 'user', 'de', 'seo', 'using-a-sitemap.md', 'Verwendung einer Sitemap', '2023-02-11 12:20:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Title_Tag', 'user', 'de', 'seo', 'using-the-title-tag.md', 'Den Titel-Tag verwenden', '2023-02-11 12:20:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Meta_Description', 'user', 'de', 'seo', 'using-the-meta-description.md', 'Die Meta-Beschreibung verwenden', '2023-02-11 12:20:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_Keywords', 'user', 'de', 'seo', 'using-keywords.md', 'Schlüsselwörter verwenden', '2023-02-11 12:20:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Important_SEO_Points_To_Remember', 'user', 'de', 'seo', 'important-seo-points-to-remember.md', 'Wichtige SEO Punkte die man wissen sollte', '2023-02-11 12:20:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs', 'user', 'de', 'seo', 'enabling-search-engine-friendly-sef-urls.md', 'Suchmaschinenfreundliche (SEF) URLs aktivieren', '2023-02-11 12:20:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Apache', 'user', 'de', 'seo', 'enabling-search-engine-friendly-sef-urls-on-apache.md', 'Suchmaschinenfreundliche (SEF) URLs in Apache aktivieren', '2023-02-11 12:20:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Nginx', 'user', 'de', 'seo', 'enabling-search-engine-friendly-sef-urls-on-nginx.md', 'Suchmaschinenfreundliche (SEF) URLs in Nginx aktivieren', '2023-02-11 12:21:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Cache', 'user', 'de', 'system', 'cache.md', 'Cache', '2023-02-11 12:21:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Backup_Basics_for_a_Joomla!_Web_Site', 'user', 'de', 'system', 'backup-basics-for-a-joomla-web-site.md', 'Backup-Grundlagen für eine Joomla!-Webseite', '2023-02-11 12:21:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Copying_a_Joomla_website', 'user', 'de', 'system', 'copying-a-joomla-website.md', 'Eine Joomla!-Website kopieren', '2023-02-11 12:21:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Database_Table_Prefix', 'user', 'de', 'system', 'database-table-prefix.md', 'Datenbanktabellenpräfix', '2023-02-11 12:21:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_To_Use_Content_Tags_in_Joomla', 'user', 'de', 'tags', 'how-to-use-content-tags-in-joomla.md', 'Wie man Schlagwörter in Joomla verwendet', '2023-02-11 12:21:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Visual_Studio_Code_Primer', 'user', 'de', 'test-installations', 'visual-studio-code-primer.md', 'Einführung in Visual Studio-Code', '2023-02-11 12:21:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'de', 'users', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'Wie kann das Administrator Passwort wieder hergestellt oder zurückgesetzt werden?', '2023-02-11 12:22:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Workflow', 'user', 'de', 'workflows', 'workflow.md', 'Workflow', '2023-02-11 12:22:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Workflow/Scenarios', 'user', 'de', 'workflows', 'workflow-scenarios.md', 'Workflow/Szenarien', '2023-02-11 12:22:17') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Article', 'user', 'es', 'getting-started', 'adding-a-new-article.md', 'Añadir un Artículo Nuevo', '2023-02-11 12:40:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Installing_Joomla', 'user', 'es', 'getting-started', 'installing-joomla.md', 'Instalación de Joomla', '2023-02-11 12:40:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Logging_in_to_Joomla', 'user', 'es', 'getting-started', 'logging-in-to-joomla.md', 'Iniciar Sesión en Joomla', '2023-02-11 12:40:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Article', 'user', 'es', 'articles', 'adding-a-new-article.md', 'Añadir un Artículo Nuevo', '2023-02-11 12:40:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Deleting_an_Article', 'user', 'es', 'articles', 'deleting-an-article.md', 'Deleting an Article', '2023-02-11 12:40:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Archive_an_Article', 'user', 'es', 'articles', 'how-to-archive-an-article.md', 'How to Archive an Article', '2023-02-11 12:40:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_an_image_to_an_article', 'user', 'es', 'articles', 'adding-an-image-to-an-article.md', 'Agregar una imagen a un artículo', '2023-02-11 12:41:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'es', 'articles', 'adding-a-menu-link-in-an-article.md', 'Agregar un enlace de menú en un artículo', '2023-02-11 12:41:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Meta_Description', 'user', 'es', 'articles-metadata', 'using-the-meta-description.md', 'El uso de la Meta Etiqueta Descripción (Description)', '2023-02-11 12:41:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Title_Tag', 'user', 'es', 'articles-metadata', 'using-the-title-tag.md', 'El Uso de la etiqueta Title', '2023-02-11 12:41:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Preconfigured_htaccess', 'user', 'es', 'configuration', 'preconfigured-htaccess.md', 'htaccess preconfigurado', '2023-02-11 12:41:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_www_to_a_url', 'user', 'es', 'configuration', 'adding-www-to-a-url.md', 'Agregar www a una url', '2023-02-11 12:41:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_block_directory_scans_using_htaccess?', 'user', 'es', 'configuration', 'how-do-you-block-directory-scans-using-htaccess-3f.md', 'Cómo bloquear análisis del directorio usando htaccess?', '2023-02-11 12:41:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_convert_an_htaccess.txt_file_into_a_.htaccess_file?', 'user', 'es', 'configuration', 'how-do-you-convert-an-htaccess-txt-file-into-a-htaccess-file-3f.md', '¿Cómo convertir un archivo htaccess.txt en uno .htaccess?', '2023-02-11 12:41:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Content_editors', 'user', 'es', 'editors', 'content-editors.md', 'Editores de contenido', '2023-02-11 12:41:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Free_and_Commercial_extensions', 'user', 'es', 'extensions', 'free-and-commercial-extensions.md', 'Extensiones Libres y Comerciales', '2023-02-11 12:42:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_an_extension', 'user', 'es', 'extensions', 'installing-an-extension.md', 'Instalar una extensión', '2023-02-11 12:42:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Overrides', 'user', 'es', 'fields', 'adding-custom-fields-overrides.md', 'Añadir campos personalizados/Sobrescrituras', '2023-02-11 12:42:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Parameters_for_all_Custom_Fields', 'user', 'es', 'fields', 'adding-custom-fields-parameters-for-all-custom-fields.md', 'Agregar campos personalizados/parámetros para todos los Campos Personalizados', '2023-02-11 12:42:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Calendar_Field', 'user', 'es', 'fields', 'adding-custom-fields-calendar-field.md', 'Agregar campos personalizados - Campo de calendario', '2023-02-11 12:42:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Checkboxes_Field', 'user', 'es', 'fields', 'adding-custom-fields-checkboxes-field.md', 'Agregar campos personalizados - Campo de checkbox', '2023-02-11 12:42:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Color_Field', 'user', 'es', 'fields', 'adding-custom-fields-color-field.md', 'Agregar campos personalizados - Campo de color', '2023-02-11 12:42:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Editor_Field', 'user', 'es', 'fields', 'adding-custom-fields-editor-field.md', 'Agregar campos personalizados - Campo de editor', '2023-02-11 12:42:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Integer_Field', 'user', 'es', 'fields', 'adding-custom-fields-integer-field.md', 'Agregar campos personalizados / Campo de Entero', '2023-02-11 12:42:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/List_Field', 'user', 'es', 'fields', 'adding-custom-fields-list-field.md', 'Agregar campos personalizados/Campo de Lista', '2023-02-11 12:42:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Moving_the_site_among_directories/sub-directories', 'user', 'es', 'hosting', 'moving-the-site-among-directories-sub-directories.md', 'Mover el sitio entre directorios/subdirectorios', '2023-02-11 12:42:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Nginx', 'user', 'es', 'hosting', 'nginx.md', 'Nginx', '2023-02-11 12:42:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_check_if_mod_rewrite_is_enabled_on_your_server', 'user', 'es', 'hosting', 'how-to-check-if-mod-rewrite-is-enabled-on-your-server.md', 'Cómo verificar si mod_rewrite está activo en tu servidor', '2023-02-11 12:43:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_an_FTP_client_to_upload_files', 'user', 'es', 'hosting', 'using-an-ftp-client-to-upload-files.md', 'El uso de un cliente FTP para subir archivos', '2023-02-11 12:43:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_build_your_free_Joomla_Website', 'user', 'es', 'installation-variations', 'how-to-build-your-free-joomla-website.md', 'Cómo construir tu sitio Web de Joomla! gratis', '2023-02-11 12:43:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_Joomla_on_a_Raspberry_Pi', 'user', 'es', 'installation-variations', 'installing-joomla-on-a-raspberry-pi.md', 'Installing Joomla on a Raspberry Pi', '2023-02-11 12:43:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Debugging_a_translation', 'user', 'es', 'languages', 'debugging-a-translation.md', 'Depurar una traducción', '2023-02-11 12:43:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Managing_Media', 'user', 'es', 'media', 'managing-media.md', 'Managing Media', '2023-02-11 12:43:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Media:_Options', 'user', 'es', 'media', 'media-options.md', 'Multimedia: Opciones', '2023-02-11 12:43:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Menu', 'user', 'es', 'menus', 'adding-a-new-menu.md', 'Agregar un nuevo menú', '2023-02-11 12:43:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'es', 'menus', 'adding-a-menu-link-in-an-article.md', 'Agregar un enlace de menú en un artículo', '2023-02-11 12:43:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_Migrate', 'user', 'es', 'migration', 'why-migrate.md', '¿Por qué migrar?', '2023-02-11 12:43:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_3.x_to_4.x_Step_by_Step_Migration', 'user', 'es', 'migration', 'joomla-3-x-to-4-x-step-by-step-migration.md', 'Migración Paso a Paso de Joomla 3.x a 4.x', '2023-02-11 12:43:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Migration_Step_by_Step_Self_Assessment', 'user', 'es', 'migration', 'migration-step-by-step-self-assessment.md', 'Migración paso a paso. Autoevaluación', '2023-02-11 12:43:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Update_fails_with_an_error_message', 'user', 'es', 'migration', 'update-fails-with-an-error-message.md', 'Falla la actualización y aparece un mensaje de error', '2023-02-11 12:43:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Updating_Joomla_(Install_Method)', 'user', 'es', 'migration', 'updating-joomla-install-method.md', 'Actualizar Joomla (Método de instalación)', '2023-02-11 12:43:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Updating_Joomla_(Update_Method)', 'user', 'es', 'migration', 'updating-joomla-update-method.md', 'Actualización de Joomla! (Método de Actualización)', '2023-02-11 12:43:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_Migration_-_Joomla_1.5_to_4', 'user', 'es', 'migration', 'planning-migration-joomla-1-5-to-4.md', 'Planificación de una migración - De Joomla 1.5 a la 3', '2023-02-11 12:44:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Migration', 'user', 'es', 'migration', 'planning-for-migration.md', 'Planificación de una migración', '2023-02-11 12:44:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Mini-Migration_-_Joomla_3.10.x_to_4.x', 'user', 'es', 'migration', 'planning-for-mini-migration-joomla-3-10-x-to-4-x.md', 'Planificación para Mini-Migración - Joomla 3.10.x a 4.x', '2023-02-11 12:44:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Potential_backward_compatibility_issues_in_Joomla_4', 'user', 'es', 'migration', 'potential-backward-compatibility-issues-in-joomla-4.md', 'Posibles problemas de retrocompatibilidad en Joomla 4', '2023-02-11 12:44:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Pre-Update_Check', 'user', 'es', 'migration', 'pre-update-check.md', 'Comprobación de Pre-Actualización', '2023-02-11 12:44:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Template_Considerations_During_Migration', 'user', 'es', 'migration', 'template-considerations-during-migration.md', 'Consideraciones sobre la plantilla en la migración', '2023-02-11 12:44:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_put_a_module_inside_an_article?', 'user', 'es', 'modules', 'how-do-you-put-a-module-inside-an-article-3f.md', '¿Como se puede poner un módulo dentro de un artículo?', '2023-02-11 12:44:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_the_Login_Form_module', 'user', 'es', 'modules', 'enabling-the-login-form-module.md', 'Habilitar el módulo de formulario de inicio de sesión', '2023-02-11 12:44:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Changing_the_Login_Form_module_settings', 'user', 'es', 'modules', 'changing-the-login-form-module-settings.md', 'Cambiar la configuración del Formulario del módulo de Inicio de Sesión', '2023-02-11 12:44:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Module_Class_Suffix', 'user', 'es', 'modules', 'module-class-suffix.md', 'Sufijo de clase de módulo', '2023-02-11 12:44:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Standard_Module_Chromes', 'user', 'es', 'modules', 'standard-module-chromes.md', 'Módulo estándar Chromes', '2023-02-11 12:44:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Show_a_Calendar_Month_List_of_Archived_Articles_Using_a_Module', 'user', 'es', 'modules', 'how-to-show-a-calendar-month-list-of-archived-articles-using-a-module.md', 'How to Show a Calendar Month List of Archived Articles Using a Module', '2023-02-11 12:44:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_add_a_PayPal_button?', 'user', 'es', 'modules', 'how-do-you-add-a-paypal-button-3f.md', '¿Cómo agregar un botón de PayPal?', '2023-02-11 12:44:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'es', 'problems', 'how-do-you-recover-or-reset-your-admin-password-3f.md', '¿Cómo recuperar o restablecer su contraseña de administrador?', '2023-02-11 12:44:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_HTTPS_on_your_site', 'user', 'es', 'security', 'enabling-https-on-your-site.md', 'Habilitando HTTPS en tu sitio web', '2023-02-11 12:45:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Making_your_site_Search_Engine_Friendly', 'user', 'es', 'seo', 'making-your-site-search-engine-friendly.md', 'Haciendo tu sitio amigable con los motores de búsqueda', '2023-02-11 12:45:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Search_Engine_Friendly_URLs', 'user', 'es', 'seo', 'search-engine-friendly-urls.md', 'URLs Amigables a los Buscadores (Search Engine Friendly URLs)', '2023-02-11 12:45:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_A_Sitemap', 'user', 'es', 'seo', 'using-a-sitemap.md', 'Usar un Sitemap', '2023-02-11 12:45:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Title_Tag', 'user', 'es', 'seo', 'using-the-title-tag.md', 'El Uso de la etiqueta Title', '2023-02-11 12:45:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Meta_Description', 'user', 'es', 'seo', 'using-the-meta-description.md', 'El uso de la Meta Etiqueta Descripción (Description)', '2023-02-11 12:45:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_Keywords', 'user', 'es', 'seo', 'using-keywords.md', 'Metapalabras clave', '2023-02-11 12:45:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Semantic_HTML_Markup', 'user', 'es', 'seo', 'semantic-html-markup.md', 'Etiquetado HTML Semántico', '2023-02-11 12:45:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Linking_To_Other_Sites', 'user', 'es', 'seo', 'linking-to-other-sites.md', 'Enlaces a otros sitios', '2023-02-11 12:45:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Important_SEO_Points_To_Remember', 'user', 'es', 'seo', 'important-seo-points-to-remember.md', 'Puntos importantes sobre SEO, para recordar', '2023-02-11 12:45:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Apache', 'user', 'es', 'seo', 'enabling-search-engine-friendly-sef-urls-on-apache.md', 'Activas URLs optimizadas para motores de búsqueda (SEF) en Apache', '2023-02-11 12:45:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Cache', 'user', 'es', 'system', 'cache.md', 'Caché', '2023-02-11 12:45:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Backup_Basics_for_a_Joomla!_Web_Site', 'user', 'es', 'system', 'backup-basics-for-a-joomla-web-site.md', 'Conceptos básicos sobre copia de seguridad de un sitio web Joomla!', '2023-02-11 12:46:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Copying_a_Joomla_website', 'user', 'es', 'system', 'copying-a-joomla-website.md', 'Copiar un sitio web Joomla!', '2023-02-11 12:46:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Database_Table_Prefix', 'user', 'es', 'system', 'database-table-prefix.md', 'Prefijo de tabla de la Base de Datos', '2023-02-11 12:46:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'es', 'users', 'how-do-you-recover-or-reset-your-admin-password-3f.md', '¿Cómo recuperar o restablecer su contraseña de administrador?', '2023-02-11 12:46:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Workflow', 'user', 'es', 'workflows', 'workflow.md', 'Flujo de trabajo', '2023-02-11 12:47:03') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Article', 'user', 'fr', 'getting-started', 'adding-a-new-article.md', 'Ajouter un nouvel article', '2023-02-11 12:47:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Hosting_Setup', 'user', 'fr', 'getting-started', 'hosting-setup.md', 'Configuration de l''hébergement', '2023-02-11 12:47:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Installing_Joomla', 'user', 'fr', 'getting-started', 'installing-joomla.md', 'Installation de Joomla!', '2023-02-11 12:47:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Logging_in_to_Joomla', 'user', 'fr', 'getting-started', 'logging-in-to-joomla.md', 'Se connecter sur Joomla', '2023-02-11 12:47:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_an_Article', 'user', 'fr', 'getting-started', 'getting-started-adding-an-article.md', 'Mise en route : Ajout d''un article', '2023-02-11 12:47:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Category', 'user', 'fr', 'getting-started', 'getting-started-adding-a-category.md', 'Mise en route : Ajout d''une catégorie', '2023-02-11 12:47:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Menu_Item', 'user', 'fr', 'getting-started', 'getting-started-adding-a-menu-item.md', 'Mise en route : Ajout d''un élément de menu', '2023-02-11 12:47:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Module', 'user', 'fr', 'getting-started', 'getting-started-adding-a-module.md', 'Premiers pas : Ajout d''un module', '2023-02-11 12:47:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Site_and_Administrator_templates', 'user', 'fr', 'getting-started', 'getting-started-site-and-administrator-templates.md', 'Prise en main : Templates de site et d''administration', '2023-02-11 12:47:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Article', 'user', 'fr', 'articles', 'adding-a-new-article.md', 'Ajouter un nouvel article', '2023-02-11 12:48:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Deleting_an_Article', 'user', 'fr', 'articles', 'deleting-an-article.md', 'Deleting an Article', '2023-02-11 12:48:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Archive_an_Article', 'user', 'fr', 'articles', 'how-to-archive-an-article.md', 'How to Archive an Article', '2023-02-11 12:48:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_an_image_to_an_article', 'user', 'fr', 'articles', 'adding-an-image-to-an-article.md', 'Ajouter une image à un article', '2023-02-11 12:48:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'fr', 'articles', 'adding-a-menu-link-in-an-article.md', 'Ajouter un lien de menu à un article', '2023-02-11 12:48:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Restricting_access_to_read_more', 'user', 'fr', 'articles-access', 'restricting-access-to-read-more.md', 'Restreindre l''accès au "Lire la suite"', '2023-02-11 12:48:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Meta_Description', 'user', 'fr', 'articles-metadata', 'using-the-meta-description.md', 'Utilisation de la méta description', '2023-02-11 12:48:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Title_Tag', 'user', 'fr', 'articles-metadata', 'using-the-title-tag.md', 'Utiliser la balise Titre', '2023-02-11 12:48:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Preconfigured_htaccess', 'user', 'fr', 'configuration', 'preconfigured-htaccess.md', 'htaccess préconfiguré', '2023-02-11 12:48:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_www_to_a_url', 'user', 'fr', 'configuration', 'adding-www-to-a-url.md', 'Ajouter les www à une url', '2023-02-11 12:48:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_block_directory_scans_using_htaccess?', 'user', 'fr', 'configuration', 'how-do-you-block-directory-scans-using-htaccess-3f.md', 'Comment bloquer les analyses de répertoires à l''aide du htaccess ?', '2023-02-11 12:48:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_convert_an_htaccess.txt_file_into_a_.htaccess_file?', 'user', 'fr', 'configuration', 'how-do-you-convert-an-htaccess-txt-file-into-a-htaccess-file-3f.md', 'Comment convertir un fichier htaccess.txt en fichier .htaccess ?', '2023-02-11 12:48:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Content_editors', 'user', 'fr', 'editors', 'content-editors.md', 'Les éditeurs de contenu', '2023-02-11 12:49:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Free_and_Commercial_extensions', 'user', 'fr', 'extensions', 'free-and-commercial-extensions.md', 'Extensions gratuites et payantes', '2023-02-11 12:49:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_choose_secure_extensions?', 'user', 'fr', 'extensions', 'how-do-you-choose-secure-extensions-3f.md', 'Comment choisir des extensions sécurisées ?', '2023-02-11 12:49:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_an_extension', 'user', 'fr', 'extensions', 'installing-an-extension.md', 'Installation d''une extension', '2023-02-11 12:49:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Overrides', 'user', 'fr', 'fields', 'adding-custom-fields-overrides.md', 'Champs personnalisés : les substitutions', '2023-02-11 12:49:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Parameters_for_all_Custom_Fields', 'user', 'fr', 'fields', 'adding-custom-fields-parameters-for-all-custom-fields.md', 'Ajout de champs personnalisés/Paramètres pour tous les champs personnalisés', '2023-02-11 12:49:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/What_components_are_supporting_custom_fields', 'user', 'fr', 'fields', 'adding-custom-fields-what-components-are-supporting-custom-fields.md', 'Ajout de champs personnalisés/Composants supportant les champs personnalisés', '2023-02-11 12:49:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Calendar_Field', 'user', 'fr', 'fields', 'adding-custom-fields-calendar-field.md', 'Ajout de champs personnalisés/Champ Calendrier', '2023-02-11 12:49:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Checkboxes_Field', 'user', 'fr', 'fields', 'adding-custom-fields-checkboxes-field.md', 'Ajout de champs personnalisés/Cases à cocher', '2023-02-11 12:49:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Color_Field', 'user', 'fr', 'fields', 'adding-custom-fields-color-field.md', 'Ajout de champs personnalisés/Champ Couleur', '2023-02-11 12:49:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Editor_Field', 'user', 'fr', 'fields', 'adding-custom-fields-editor-field.md', 'Ajout de champs personnalisés/Champ Editeur', '2023-02-11 12:49:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Integer_Field', 'user', 'fr', 'fields', 'adding-custom-fields-integer-field.md', 'Ajout de champs personnalisés/Champ Nombre entier', '2023-02-11 12:49:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/List_Field', 'user', 'fr', 'fields', 'adding-custom-fields-list-field.md', 'Ajout de champs personnalisés/Champ Liste', '2023-02-11 12:49:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/List_of_Images_Field', 'user', 'fr', 'fields', 'adding-custom-fields-list-of-images-field.md', 'Ajout de champs personnalisés/Champ Liste d''images', '2023-02-11 12:49:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Media_Field', 'user', 'fr', 'fields', 'adding-custom-fields-media-field.md', 'Ajout de champs personnalisés/Champ Médias', '2023-02-11 12:49:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Radio_Field', 'user', 'fr', 'fields', 'adding-custom-fields-radio-field.md', 'Ajout de champs personnalisés/Champ Radio', '2023-02-11 12:49:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Sql_Field', 'user', 'fr', 'fields', 'adding-custom-fields-sql-field.md', 'Ajout de champs personnalisés/Champ SQL', '2023-02-11 12:49:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Text_Field', 'user', 'fr', 'fields', 'adding-custom-fields-text-field.md', 'Ajout de champs personnalisés/Champ Texte', '2023-02-11 12:50:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Textarea_Field', 'user', 'fr', 'fields', 'adding-custom-fields-textarea-field.md', 'Ajout de champs personnalisés/Champ Zone de texte', '2023-02-11 12:50:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Url_Field', 'user', 'fr', 'fields', 'adding-custom-fields-url-field.md', 'Ajout de champs personnalisés/Champ URL', '2023-02-11 12:50:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/User_Field', 'user', 'fr', 'fields', 'adding-custom-fields-user-field.md', 'Ajout de champs personnalisés/Champ Utilisateur', '2023-02-11 12:50:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Usergroup_Field', 'user', 'fr', 'fields', 'adding-custom-fields-usergroup-field.md', 'Ajout de champs personnalisés/Champ Groupes d''utilisateurs', '2023-02-11 12:50:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Hosting_Setup', 'user', 'fr', 'hosting', 'hosting-setup.md', 'Configuration de l''hébergement', '2023-02-11 12:50:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Nginx', 'user', 'fr', 'hosting', 'nginx.md', 'Nginx', '2023-02-11 12:50:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_check_if_mod_rewrite_is_enabled_on_your_server', 'user', 'fr', 'hosting', 'how-to-check-if-mod-rewrite-is-enabled-on-your-server.md', 'Comment vérifier si mod rewrite est activé sur votre serveur', '2023-02-11 12:50:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_an_FTP_client_to_upload_files', 'user', 'fr', 'hosting', 'using-an-ftp-client-to-upload-files.md', 'Utiliser un client FTP pour charger des fichiers', '2023-02-11 12:50:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_build_your_free_Joomla_Website', 'user', 'fr', 'installation-variations', 'how-to-build-your-free-joomla-website.md', 'Comment réaliser gratuitement votre site web Joomla!', '2023-02-11 12:50:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('FreeBSD_Installation', 'user', 'fr', 'installation-variations', 'freebsd-installation.md', 'FreeBSD Installation', '2023-02-11 12:50:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_Joomla_on_a_Raspberry_Pi', 'user', 'fr', 'installation-variations', 'installing-joomla-on-a-raspberry-pi.md', 'Installing Joomla on a Raspberry Pi', '2023-02-11 12:50:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Debugging_a_translation', 'user', 'fr', 'languages', 'debugging-a-translation.md', 'Débogage d''une traduction', '2023-02-11 12:50:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Managing_Media', 'user', 'fr', 'media', 'managing-media.md', 'Managing Media', '2023-02-11 12:50:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Media:_Options', 'user', 'fr', 'media', 'media-options.md', 'Médias : Paramètres', '2023-02-11 12:50:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Menu', 'user', 'fr', 'menus', 'adding-a-new-menu.md', 'Ajouter un nouveau menu', '2023-02-11 12:50:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'fr', 'menus', 'adding-a-menu-link-in-an-article.md', 'Ajouter un lien de menu à un article', '2023-02-11 12:51:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_Migrate', 'user', 'fr', 'migration', 'why-migrate.md', 'Pourquoi Migrer', '2023-02-11 12:51:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_3.x_to_4.x_Step_by_Step_Migration', 'user', 'fr', 'migration', 'joomla-3-x-to-4-x-step-by-step-migration.md', 'Migration Joomla 3.x vers 4.x étape par étape', '2023-02-11 12:51:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Migration_Step_by_Step_Self_Assessment', 'user', 'fr', 'migration', 'migration-step-by-step-self-assessment.md', 'Migration étape par étape - Auto-évaluation', '2023-02-11 12:51:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Update_fails_with_an_error_message', 'user', 'fr', 'migration', 'update-fails-with-an-error-message.md', 'Echec de la mise à jour avec un message d''erreur', '2023-02-11 12:51:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Updating_Joomla_(Install_Method)', 'user', 'fr', 'migration', 'updating-joomla-install-method.md', 'Mise à jour de Joomla! (méthode d''installation)', '2023-02-11 12:51:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Updating_Joomla_(Update_Method)', 'user', 'fr', 'migration', 'updating-joomla-update-method.md', 'Mettre à jour Joomla! (méthode de mise à jour)', '2023-02-11 12:51:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_Migration_-_Joomla_1.5_to_4', 'user', 'fr', 'migration', 'planning-migration-joomla-1-5-to-4.md', 'Planification d''une migration - Joomla! 1.5 vers 3.x', '2023-02-11 12:51:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Migration', 'user', 'fr', 'migration', 'planning-for-migration.md', 'Planification d''une migration', '2023-02-11 12:51:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Mini-Migration_-_Joomla_3.10.x_to_4.x', 'user', 'fr', 'migration', 'planning-for-mini-migration-joomla-3-10-x-to-4-x.md', 'Planning d''une mini-migration - Joomla 3.10 à 4.x', '2023-02-11 12:51:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Potential_backward_compatibility_issues_in_Joomla_4', 'user', 'fr', 'migration', 'potential-backward-compatibility-issues-in-joomla-4.md', 'Éventuelles anomalies  de rétro-compatibilité dans Joomla! 4', '2023-02-11 12:51:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Pre-Update_Check', 'user', 'fr', 'migration', 'pre-update-check.md', 'Vérification préalable à la mise à jour', '2023-02-11 12:51:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Template_Considerations_During_Migration', 'user', 'fr', 'migration', 'template-considerations-during-migration.md', 'Considérations en matière de template lors d''une migration', '2023-02-11 12:51:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_put_a_module_inside_an_article?', 'user', 'fr', 'modules', 'how-do-you-put-a-module-inside-an-article-3f.md', 'Comment placer un module dans un article ?', '2023-02-11 12:51:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_the_Login_Form_module', 'user', 'fr', 'modules', 'enabling-the-login-form-module.md', 'Enabling the Login Form module', '2023-02-11 12:51:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Changing_the_Login_Form_module_settings', 'user', 'fr', 'modules', 'changing-the-login-form-module-settings.md', 'Modification des paramètres du module de Formulaire de Connexion', '2023-02-11 12:51:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Customising_the_Login_Form_module', 'user', 'fr', 'modules', 'customising-the-login-form-module.md', 'Customising the Login Form module', '2023-02-11 12:51:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Module_Class_Suffix', 'user', 'fr', 'modules', 'module-class-suffix.md', 'Suffixe de Classe de Module', '2023-02-11 12:51:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Standard_Module_Chromes', 'user', 'fr', 'modules', 'standard-module-chromes.md', 'Module Chromes standard', '2023-02-11 12:51:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Show_a_Calendar_Month_List_of_Archived_Articles_Using_a_Module', 'user', 'fr', 'modules', 'how-to-show-a-calendar-month-list-of-archived-articles-using-a-module.md', 'How to Show a Calendar Month List of Archived Articles Using a Module', '2023-02-11 12:51:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_add_a_PayPal_button?', 'user', 'fr', 'modules', 'how-do-you-add-a-paypal-button-3f.md', 'Comment ajouter un bouton PayPal?', '2023-02-11 12:52:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Validating_against_accessibility_standards', 'user', 'fr', 'performance', 'validating-against-accessibility-standards.md', 'Validation au regard des normes d''accessibilité', '2023-02-11 12:52:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Plugin_Joomla_Update_Notification', 'user', 'fr', 'plugins', 'plugin-joomla-update-notification.md', 'Plugin Joomla Update Notification', '2023-02-11 12:52:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'fr', 'problems', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'Comment récupérer ou réinitialiser votre mot de passe d''administration ?', '2023-02-11 12:52:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_and_MySQL_8', 'user', 'fr', 'problems', 'joomla-and-mysql-8.md', 'Joomla et MySQL 8', '2023-02-11 12:52:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_HTTPS_on_your_site', 'user', 'fr', 'security', 'enabling-https-on-your-site.md', 'Activer HTTPS sur votre site', '2023-02-11 12:52:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Making_your_site_Search_Engine_Friendly', 'user', 'fr', 'seo', 'making-your-site-search-engine-friendly.md', 'Rendre votre site compatible avec les moteurs de recherche', '2023-02-11 12:52:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Search_Engine_Friendly_URLs', 'user', 'fr', 'seo', 'search-engine-friendly-urls.md', 'Réécriture des URL en clair (Search Engine Friendly URLs)', '2023-02-11 12:52:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_A_Sitemap', 'user', 'fr', 'seo', 'using-a-sitemap.md', 'Utiliser un plan de site', '2023-02-11 12:52:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Title_Tag', 'user', 'fr', 'seo', 'using-the-title-tag.md', 'Utiliser la balise Titre', '2023-02-11 12:52:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Meta_Description', 'user', 'fr', 'seo', 'using-the-meta-description.md', 'Utilisation de la méta description', '2023-02-11 12:52:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_Keywords', 'user', 'fr', 'seo', 'using-keywords.md', 'Mots clés', '2023-02-11 12:52:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Semantic_HTML_Markup', 'user', 'fr', 'seo', 'semantic-html-markup.md', 'Balises HTML sémantique', '2023-02-11 12:52:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Linking_To_Other_Sites', 'user', 'fr', 'seo', 'linking-to-other-sites.md', 'Liens vers d''autres sites', '2023-02-11 12:53:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Important_SEO_Points_To_Remember', 'user', 'fr', 'seo', 'important-seo-points-to-remember.md', 'Important SEO Points To Remember', '2023-02-11 12:53:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Common_problems_when_enabling_Search_Engine_Friendly_(SEF)_URLs', 'user', 'fr', 'seo', 'common-problems-when-enabling-search-engine-friendly-sef-urls.md', 'Problèmes courants lors de l''activation de la réécriture d''URL en clair (SEF)', '2023-02-11 12:53:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs', 'user', 'fr', 'seo', 'enabling-search-engine-friendly-sef-urls.md', 'Autoriser les réécriture d''URL en clair  (SEF).', '2023-02-11 12:53:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Apache', 'user', 'fr', 'seo', 'enabling-search-engine-friendly-sef-urls-on-apache.md', 'Autoriser les réécriture d''URL en clair  (SEF) dans Apache.', '2023-02-11 12:53:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Hiawatha', 'user', 'fr', 'seo', 'enabling-search-engine-friendly-sef-urls-on-hiawatha.md', 'Autoriser les réécriture d''URL en clair  (SEF) dans Hiawatha', '2023-02-11 12:53:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_IIS/IIS7', 'user', 'fr', 'seo', 'enabling-search-engine-friendly-sef-urls-on-iis-iis7.md', 'Autoriser les réécriture d''URL en clair  (SEF) avec IIS/IIS7', '2023-02-11 12:53:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Nginx', 'user', 'fr', 'seo', 'enabling-search-engine-friendly-sef-urls-on-nginx.md', 'Autoriser les réécritures d''URL en clair  (SEF) dans Nginx.', '2023-02-11 12:53:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Cache', 'user', 'fr', 'system', 'cache.md', 'Cache', '2023-02-11 12:53:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Backup_Basics_for_a_Joomla!_Web_Site', 'user', 'fr', 'system', 'backup-basics-for-a-joomla-web-site.md', 'Sauvegarde d''un site Joomla! - principes de base', '2023-02-11 12:53:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Copying_a_Joomla_website', 'user', 'fr', 'system', 'copying-a-joomla-website.md', 'Copier un site Joomla!', '2023-02-11 12:53:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Database_Table_Prefix', 'user', 'fr', 'system', 'database-table-prefix.md', 'Préfixe de Table de Base De Données', '2023-02-11 12:53:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('WebAuthn_Passwordless_Login', 'user', 'fr', 'users', 'webauthn-passwordless-login.md', 'WebAuthn Connexion sans mot de passe', '2023-02-11 12:54:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'fr', 'users', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'Comment récupérer ou réinitialiser votre mot de passe d''administration ?', '2023-02-11 12:54:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Workflow', 'user', 'fr', 'workflows', 'workflow.md', 'Flux de travail', '2023-02-11 12:54:20') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Installing_Joomla', 'user', 'nl', 'getting-started', 'installing-joomla.md', 'Het installeren van Joomla', '2023-02-11 13:03:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_an_Article', 'user', 'nl', 'getting-started', 'getting-started-adding-an-article.md', 'Aan de slag: Een artikel toevoegen', '2023-02-11 13:03:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Category', 'user', 'nl', 'getting-started', 'getting-started-adding-a-category.md', 'Aan de slag: Een categorie toevoegen', '2023-02-11 13:03:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Menu_Item', 'user', 'nl', 'getting-started', 'getting-started-adding-a-menu-item.md', 'Aan de slag: Een menu-item toevoegen', '2023-02-11 13:03:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Module', 'user', 'nl', 'getting-started', 'getting-started-adding-a-module.md', 'Aan de slag: Een module toevoegen', '2023-02-11 13:03:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Site_and_Administrator_templates', 'user', 'nl', 'getting-started', 'getting-started-site-and-administrator-templates.md', 'Aan de slag: Website- en Beheerder-templates', '2023-02-11 13:04:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Deleting_an_Article', 'user', 'nl', 'articles', 'deleting-an-article.md', 'Deleting an Article', '2023-02-11 13:04:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Archive_an_Article', 'user', 'nl', 'articles', 'how-to-archive-an-article.md', 'Hoe een artikel archiveren', '2023-02-11 13:04:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_an_image_to_an_article', 'user', 'nl', 'articles', 'adding-an-image-to-an-article.md', 'Een afbeelding toevoegen aan een artikel', '2023-02-11 13:04:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'nl', 'articles', 'adding-a-menu-link-in-an-article.md', 'Een menu-link toevoegen in een artikel', '2023-02-11 13:04:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Scheduling_the_publication_of_an_article', 'user', 'nl', 'articles-access', 'scheduling-the-publication-of-an-article.md', 'Het plannen van de publicatie van een artikel', '2023-02-11 13:04:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Restricting_access_to_read_more', 'user', 'nl', 'articles-access', 'restricting-access-to-read-more.md', 'Toegang tot "lees meer" beperken', '2023-02-11 13:04:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Meta_Description', 'user', 'nl', 'articles-metadata', 'using-the-meta-description.md', 'Gebruik van de metabeschrijving', '2023-02-11 13:04:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Title_Tag', 'user', 'nl', 'articles-metadata', 'using-the-title-tag.md', 'De titel Tag gebruiken', '2023-02-11 13:04:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Preconfigured_htaccess', 'user', 'nl', 'configuration', 'preconfigured-htaccess.md', 'Vooraf geconfigureerde htaccess', '2023-02-11 13:04:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_www_to_a_url', 'user', 'nl', 'configuration', 'adding-www-to-a-url.md', 'Het toevoegen van www aan een url', '2023-02-11 13:04:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_block_directory_scans_using_htaccess?', 'user', 'nl', 'configuration', 'how-do-you-block-directory-scans-using-htaccess-3f.md', 'Hoe blokkeert u map-scans met behulp van htaccess?', '2023-02-11 13:05:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_convert_an_htaccess.txt_file_into_a_.htaccess_file?', 'user', 'nl', 'configuration', 'how-do-you-convert-an-htaccess-txt-file-into-a-htaccess-file-3f.md', 'Hoe verandert u een een htaccess.txt bestand in een .htaccess bestand?', '2023-02-11 13:05:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Content_editors', 'user', 'nl', 'editors', 'content-editors.md', 'Tekstverwerkers', '2023-02-11 13:05:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Free_and_Commercial_extensions', 'user', 'nl', 'extensions', 'free-and-commercial-extensions.md', 'Gratis en commerciële extensies', '2023-02-11 13:05:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('What_is_a_vulnerable_extension?', 'user', 'nl', 'extensions', 'what-is-a-vulnerable-extension-3f.md', 'Wat is een kwetsbare extensie?', '2023-02-11 13:05:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_choose_secure_extensions?', 'user', 'nl', 'extensions', 'how-do-you-choose-secure-extensions-3f.md', 'Hoe kiest u veilige extensies?', '2023-02-11 13:05:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_an_extension', 'user', 'nl', 'extensions', 'installing-an-extension.md', 'Installeren van een extensie', '2023-02-11 13:05:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Overrides', 'user', 'nl', 'fields', 'adding-custom-fields-overrides.md', 'Toevoegen extra velden - Overrides', '2023-02-11 13:05:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Parameters_for_all_Custom_Fields', 'user', 'nl', 'fields', 'adding-custom-fields-parameters-for-all-custom-fields.md', 'Toevoegen van extra velden/Parameters voor alle extra velden', '2023-02-11 13:05:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/What_components_are_supporting_custom_fields', 'user', 'nl', 'fields', 'adding-custom-fields-what-components-are-supporting-custom-fields.md', 'Toevoegen extra velden/Welke componenten ondersteunen extra velden', '2023-02-11 13:05:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Calendar_Field', 'user', 'nl', 'fields', 'adding-custom-fields-calendar-field.md', 'Toevoegen extra velden/Kalender veld', '2023-02-11 13:05:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Checkboxes_Field', 'user', 'nl', 'fields', 'adding-custom-fields-checkboxes-field.md', 'Toevoegen extra velden/Selectievakjes veld', '2023-02-11 13:05:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Color_Field', 'user', 'nl', 'fields', 'adding-custom-fields-color-field.md', 'Toevoegen extra velden/Kleur veld', '2023-02-11 13:05:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Editor_Field', 'user', 'nl', 'fields', 'adding-custom-fields-editor-field.md', 'Toevoegen extra velden/Tekstverwerker veld', '2023-02-11 13:05:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Integer_Field', 'user', 'nl', 'fields', 'adding-custom-fields-integer-field.md', 'Toevoegen extra velden/Integer veld', '2023-02-11 13:05:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/List_Field', 'user', 'nl', 'fields', 'adding-custom-fields-list-field.md', 'Toevoegen extra velden/Lijst veld', '2023-02-11 13:05:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/List_of_Images_Field', 'user', 'nl', 'fields', 'adding-custom-fields-list-of-images-field.md', 'Toevoegen extra velden/Lijst met afbeeldingen veld', '2023-02-11 13:05:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Media_Field', 'user', 'nl', 'fields', 'adding-custom-fields-media-field.md', 'Toevoegen extra velden/Media veld', '2023-02-11 13:05:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Radio_Field', 'user', 'nl', 'fields', 'adding-custom-fields-radio-field.md', 'Toevoegen extra velden/Keuzerondje veld', '2023-02-11 13:06:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Sql_Field', 'user', 'nl', 'fields', 'adding-custom-fields-sql-field.md', 'Toevoegen extra velden/SQL veld', '2023-02-11 13:06:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Text_Field', 'user', 'nl', 'fields', 'adding-custom-fields-text-field.md', 'Toevoegen extra velden/Tekst veld', '2023-02-11 13:06:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Textarea_Field', 'user', 'nl', 'fields', 'adding-custom-fields-textarea-field.md', 'Toevoegen extra velden/Tekstvak veld', '2023-02-11 13:06:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Url_Field', 'user', 'nl', 'fields', 'adding-custom-fields-url-field.md', 'Toevoegen extra velden/URL veld', '2023-02-11 13:06:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/User_Field', 'user', 'nl', 'fields', 'adding-custom-fields-user-field.md', 'Toevoegen extra velden/Gebruiker veld', '2023-02-11 13:06:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Usergroup_Field', 'user', 'nl', 'fields', 'adding-custom-fields-usergroup-field.md', 'Toevoegen extra velden/Gebruikersgroep veld', '2023-02-11 13:06:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Optional_Technical_Requirements', 'user', 'nl', 'hosting', 'optional-technical-requirements.md', 'Optionele technische vereisten', '2023-02-11 13:06:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Moving_the_site_among_directories/sub-directories', 'user', 'nl', 'hosting', 'moving-the-site-among-directories-sub-directories.md', 'Verplaatsen van een website naar een andere map of submap', '2023-02-11 13:06:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Nginx', 'user', 'nl', 'hosting', 'nginx.md', 'Nginx', '2023-02-11 13:06:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_check_if_mod_rewrite_is_enabled_on_your_server', 'user', 'nl', 'hosting', 'how-to-check-if-mod-rewrite-is-enabled-on-your-server.md', 'Hoe controleert u of mod rewrite is ingeschakeld op uw sever', '2023-02-11 13:06:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_an_FTP_client_to_upload_files', 'user', 'nl', 'hosting', 'using-an-ftp-client-to-upload-files.md', 'Een FTP-client gebruiken om bestanden te uploaden.', '2023-02-11 13:06:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_build_your_free_Joomla_Website', 'user', 'nl', 'installation-variations', 'how-to-build-your-free-joomla-website.md', 'Hoe bouw je een gratis Joomla website', '2023-02-11 13:06:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_Joomla_on_a_Raspberry_Pi', 'user', 'nl', 'installation-variations', 'installing-joomla-on-a-raspberry-pi.md', 'Joomla installeren op een Raspberry Pi', '2023-02-11 13:06:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Debugging_a_translation', 'user', 'nl', 'languages', 'debugging-a-translation.md', 'Het debuggen van een vertaling', '2023-02-11 13:06:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Managing_Media', 'user', 'nl', 'media', 'managing-media.md', 'Managing Media', '2023-02-11 13:06:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Media:_Options', 'user', 'nl', 'media', 'media-options.md', 'Media: Opties', '2023-02-11 13:06:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Menu', 'user', 'nl', 'menus', 'adding-a-new-menu.md', 'Een nieuw menu toevoegen', '2023-02-11 13:07:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'nl', 'menus', 'adding-a-menu-link-in-an-article.md', 'Een menu-link toevoegen in een artikel', '2023-02-11 13:07:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_Migrate', 'user', 'nl', 'migration', 'why-migrate.md', 'Waarom migreren', '2023-02-11 13:07:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_3.x_to_4.x_Step_by_Step_Migration', 'user', 'nl', 'migration', 'joomla-3-x-to-4-x-step-by-step-migration.md', 'Stap-voor-stap migreren van Joomla 3.x naar 4.x', '2023-02-11 13:07:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Migration_Step_by_Step_Self_Assessment', 'user', 'nl', 'migration', 'migration-step-by-step-self-assessment.md', 'Stap voor stap migratie zelf-onderzoek', '2023-02-11 13:07:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Update_fails_with_an_error_message', 'user', 'nl', 'migration', 'update-fails-with-an-error-message.md', 'Update mislukt met een foutmelding', '2023-02-11 13:07:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Updating_Joomla_(Update_Method)', 'user', 'nl', 'migration', 'updating-joomla-update-method.md', 'Het updaten van Joomla (update methode)', '2023-02-11 13:07:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_Migration_-_Joomla_1.5_to_4', 'user', 'nl', 'migration', 'planning-migration-joomla-1-5-to-4.md', 'Het plannen van een migratie - Joomla 1.5 naar 3', '2023-02-11 13:07:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Migration', 'user', 'nl', 'migration', 'planning-for-migration.md', 'Het plannen van de migratie', '2023-02-11 13:07:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Mini-Migration_-_Joomla_3.10.x_to_4.x', 'user', 'nl', 'migration', 'planning-for-mini-migration-joomla-3-10-x-to-4-x.md', 'Planning voor mini-migratie - Joomla 3.10.x naar 4.x', '2023-02-11 13:07:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Potential_backward_compatibility_issues_in_Joomla_4', 'user', 'nl', 'migration', 'potential-backward-compatibility-issues-in-joomla-4.md', 'Potentiële terugwaartse compatibiliteitsproblemen in Joomla 4', '2023-02-11 13:07:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Pre-Update_Check', 'user', 'nl', 'migration', 'pre-update-check.md', 'Voor-update controle', '2023-02-11 13:07:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Template_Considerations_During_Migration', 'user', 'nl', 'migration', 'template-considerations-during-migration.md', 'Template-overwegingen tijdens een migratie', '2023-02-11 13:07:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_put_a_module_inside_an_article?', 'user', 'nl', 'modules', 'how-do-you-put-a-module-inside-an-article-3f.md', 'Hoe zet u een module in een artikel?', '2023-02-11 13:07:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_the_Login_Form_module', 'user', 'nl', 'modules', 'enabling-the-login-form-module.md', 'Publiceren van de Inloggen module', '2023-02-11 13:07:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Changing_the_Login_Form_module_settings', 'user', 'nl', 'modules', 'changing-the-login-form-module-settings.md', 'Wijzigen van de instellingen voor het Inlogformulier', '2023-02-11 13:07:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Customising_the_Login_Form_module', 'user', 'nl', 'modules', 'customising-the-login-form-module.md', 'Aanpassen van de Inloggen module', '2023-02-11 13:07:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Module_Class_Suffix', 'user', 'nl', 'modules', 'module-class-suffix.md', 'Module class achtervoegsel', '2023-02-11 13:07:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Standard_Module_Chromes', 'user', 'nl', 'modules', 'standard-module-chromes.md', 'Standaard Module Chromes', '2023-02-11 13:07:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Show_a_Calendar_Month_List_of_Archived_Articles_Using_a_Module', 'user', 'nl', 'modules', 'how-to-show-a-calendar-month-list-of-archived-articles-using-a-module.md', 'Hoe een lijst met gearchiveerde artikelen tonen per maand met behulp van een module', '2023-02-11 13:07:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_add_a_PayPal_button?', 'user', 'nl', 'modules', 'how-do-you-add-a-paypal-button-3f.md', 'Hoe voeg je een PayPal-knop toe?', '2023-02-11 13:07:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Validating_against_accessibility_standards', 'user', 'nl', 'performance', 'validating-against-accessibility-standards.md', 'Valideren ten opzichte van toegankelijkheidsnormen', '2023-02-11 13:08:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Plugin_Joomla_Update_Notification', 'user', 'nl', 'plugins', 'plugin-joomla-update-notification.md', 'Plugin Joomla Update Notification', '2023-02-11 13:08:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'nl', 'problems', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'Hoe kun je je administrator wachtwoord herstellen of opnieuw instellen?', '2023-02-11 13:08:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:FatalError', 'user', 'nl', 'problems', 'fatalerror.md', 'FatalError', '2023-02-11 13:08:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_and_MySQL_8', 'user', 'nl', 'problems', 'joomla-and-mysql-8.md', 'Joomla and MySQL 8', '2023-02-11 13:08:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_HTTPS_on_your_site', 'user', 'nl', 'security', 'enabling-https-on-your-site.md', 'HTTPS op uw website activeren', '2023-02-11 13:08:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Hosting_and_Server_Setup', 'user', 'nl', 'security', 'security-checklist-hosting-and-server-setup.md', 'Security Checklist/Hosting and Server Setup', '2023-02-11 13:08:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Making_your_site_Search_Engine_Friendly', 'user', 'nl', 'seo', 'making-your-site-search-engine-friendly.md', 'Maak uw website zoekmachine vriendelijk', '2023-02-11 13:08:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Search_Engine_Friendly_URLs', 'user', 'nl', 'seo', 'search-engine-friendly-urls.md', 'Zoekmachine vriendelijke URL''s', '2023-02-11 13:08:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_A_Sitemap', 'user', 'nl', 'seo', 'using-a-sitemap.md', 'Een sitemap gebruiken', '2023-02-11 13:08:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Title_Tag', 'user', 'nl', 'seo', 'using-the-title-tag.md', 'De titel Tag gebruiken', '2023-02-11 13:08:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Meta_Description', 'user', 'nl', 'seo', 'using-the-meta-description.md', 'Gebruik van de metabeschrijving', '2023-02-11 13:08:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_Keywords', 'user', 'nl', 'seo', 'using-keywords.md', 'Trefwoorden gebruiken', '2023-02-11 13:08:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Semantic_HTML_Markup', 'user', 'nl', 'seo', 'semantic-html-markup.md', 'Semantische HTML opmaak', '2023-02-11 13:08:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Linking_To_Other_Sites', 'user', 'nl', 'seo', 'linking-to-other-sites.md', 'Links naar andere sites', '2023-02-11 13:08:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Important_SEO_Points_To_Remember', 'user', 'nl', 'seo', 'important-seo-points-to-remember.md', 'Belangrijke SEO punten om te onthouden', '2023-02-11 13:09:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Apache', 'user', 'nl', 'seo', 'enabling-search-engine-friendly-sef-urls-on-apache.md', 'Het inschakelen van Search Engine Friendly (SEF) Url '' s in Apache', '2023-02-11 13:09:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Cache', 'user', 'nl', 'system', 'cache.md', 'Cache', '2023-02-11 13:09:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Backup_Basics_for_a_Joomla!_Web_Site', 'user', 'nl', 'system', 'backup-basics-for-a-joomla-web-site.md', 'Back-up beginselen voor een Joomla! website', '2023-02-11 13:09:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Copying_a_Joomla_website', 'user', 'nl', 'system', 'copying-a-joomla-website.md', 'Het kopiëren van een Joomla website', '2023-02-11 13:09:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Database_Table_Prefix', 'user', 'nl', 'system', 'database-table-prefix.md', 'Database tabelvoorvoegsel', '2023-02-11 13:09:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_To_Use_Content_Tags_in_Joomla', 'user', 'nl', 'tags', 'how-to-use-content-tags-in-joomla.md', 'Hoe inhouds-tags in Joomla gebruiken', '2023-02-11 13:09:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Access_Control', 'user', 'nl', 'users', 'access-control.md', 'Toegangsbeheer', '2023-02-11 13:10:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'nl', 'users', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'Hoe kun je je administrator wachtwoord herstellen of opnieuw instellen?', '2023-02-11 13:10:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Workflow', 'user', 'nl', 'workflows', 'workflow.md', 'Publicatie workflow', '2023-02-11 13:10:19') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Article', 'user', 'pt-br', 'getting-started', 'adding-a-new-article.md', 'Adicionando um novo artigo', '2023-02-11 13:42:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Installing_Joomla', 'user', 'pt-br', 'getting-started', 'installing-joomla.md', 'Instalando o Joomla', '2023-02-11 13:42:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Logging_in_to_Joomla', 'user', 'pt-br', 'getting-started', 'logging-in-to-joomla.md', 'Iniciando sessão no Joomla', '2023-02-11 13:42:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_an_Article', 'user', 'pt-br', 'getting-started', 'getting-started-adding-an-article.md', 'Primeiros passos: Adicionando um artigo', '2023-02-11 13:42:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Category', 'user', 'pt-br', 'getting-started', 'getting-started-adding-a-category.md', 'Primeiros passos: como adicionar uma categoria', '2023-02-11 13:42:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Menu_Item', 'user', 'pt-br', 'getting-started', 'getting-started-adding-a-menu-item.md', 'Introdução: Adicionando um item de menu', '2023-02-11 13:42:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Adding_a_Module', 'user', 'pt-br', 'getting-started', 'getting-started-adding-a-module.md', 'Introdução: Adicionando um módulo', '2023-02-11 13:42:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Getting_Started:_Site_and_Administrator_templates', 'user', 'pt-br', 'getting-started', 'getting-started-site-and-administrator-templates.md', 'Introdução: modelos de site e de administrador', '2023-02-11 13:42:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Article', 'user', 'pt-br', 'articles', 'adding-a-new-article.md', 'Adicionando um novo artigo', '2023-02-11 13:42:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Deleting_an_Article', 'user', 'pt-br', 'articles', 'deleting-an-article.md', 'Excluindo um artigo', '2023-02-11 13:42:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_an_image_to_an_article', 'user', 'pt-br', 'articles', 'adding-an-image-to-an-article.md', 'Adicionando uma imagem em um artigo', '2023-02-11 13:42:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'pt-br', 'articles', 'adding-a-menu-link-in-an-article.md', 'Adicionando um link de menu em um artigo', '2023-02-11 13:42:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Restricting_access_to_read_more', 'user', 'pt-br', 'articles-access', 'restricting-access-to-read-more.md', 'Restringindo o acesso a "leia mais"', '2023-02-11 13:42:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Meta_Description', 'user', 'pt-br', 'articles-metadata', 'using-the-meta-description.md', 'Usando a meta descrição', '2023-02-11 13:42:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Title_Tag', 'user', 'pt-br', 'articles-metadata', 'using-the-title-tag.md', 'Usando a tag de título', '2023-02-11 13:42:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Preconfigured_htaccess', 'user', 'pt-br', 'configuration', 'preconfigured-htaccess.md', 'Arquivo htaccess Pré-configurado', '2023-02-11 13:43:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_www_to_a_url', 'user', 'pt-br', 'configuration', 'adding-www-to-a-url.md', 'Adicionando www à url', '2023-02-11 13:43:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Content_editors', 'user', 'pt-br', 'editors', 'content-editors.md', 'Editores de conteúdo', '2023-02-11 13:43:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Installing_an_extension', 'user', 'pt-br', 'extensions', 'installing-an-extension.md', 'Instalando uma extensão', '2023-02-11 13:43:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Adding_custom_fields/Calendar_Field', 'user', 'pt-br', 'fields', 'adding-custom-fields-calendar-field.md', 'Adicionando campos customizados/Campo Calendário', '2023-02-11 13:44:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Nginx', 'user', 'pt-br', 'hosting', 'nginx.md', 'Nginx', '2023-02-11 13:44:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_Windows_file_permissions_work?', 'user', 'pt-br', 'hosting', 'how-do-windows-file-permissions-work-3f.md', 'Como funcionam as permissões de arquivo do Windows?', '2023-02-11 13:44:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_check_if_mod_rewrite_is_enabled_on_your_server', 'user', 'pt-br', 'hosting', 'how-to-check-if-mod-rewrite-is-enabled-on-your-server.md', 'Como verificar se o mod de reescrita está habilitado no seu servidor', '2023-02-11 13:44:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Managing_Media', 'user', 'pt-br', 'media', 'managing-media.md', 'Managing Media/pt-br', '2023-02-11 13:44:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Media:_Upload_Delete_Rename', 'user', 'pt-br', 'media', 'media-upload-delete-rename.md', 'Media: Upload Delete Rename/pt-br', '2023-02-11 13:44:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Media:_Image_Crop_Resize_Rotate', 'user', 'pt-br', 'media', 'media-image-crop-resize-rotate.md', 'Media: Image Crop Resize Rotate/pt-br', '2023-02-11 13:44:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Media:_Options', 'user', 'pt-br', 'media', 'media-options.md', 'Mídia: Opções', '2023-02-11 13:44:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_New_Menu', 'user', 'pt-br', 'menus', 'adding-a-new-menu.md', 'Adição de um novo menu', '2023-02-11 13:44:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'pt-br', 'menus', 'adding-a-menu-link-in-an-article.md', 'Adicionando um link de menu em um artigo', '2023-02-11 13:45:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_Migrate', 'user', 'pt-br', 'migration', 'why-migrate.md', 'Por que migrar', '2023-02-11 13:45:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Migration_Step_by_Step_Self_Assessment', 'user', 'pt-br', 'migration', 'migration-step-by-step-self-assessment.md', 'Migração Passo a Passo. Auto-Avaliação', '2023-02-11 13:45:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J3.x:Updating_Joomla_(Update_Method)', 'user', 'pt-br', 'migration', 'updating-joomla-update-method.md', 'Atualizando o Joomla (Método de Atualização)', '2023-02-11 13:45:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Migration', 'user', 'pt-br', 'migration', 'planning-for-migration.md', 'Planejando a Migração', '2023-02-11 13:45:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Template_Considerations_During_Migration', 'user', 'pt-br', 'migration', 'template-considerations-during-migration.md', 'Considerações Sobre Templates Durante a Migração', '2023-02-11 13:45:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_put_a_module_inside_an_article?', 'user', 'pt-br', 'modules', 'how-do-you-put-a-module-inside-an-article-3f.md', 'Como você coloca um módulo dentro de um artigo?', '2023-02-11 13:45:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Show_a_Calendar_Month_List_of_Archived_Articles_Using_a_Module', 'user', 'pt-br', 'modules', 'how-to-show-a-calendar-month-list-of-archived-articles-using-a-module.md', 'How to Show a Calendar Month List of Archived Articles Using a Module/pt-br', '2023-02-11 13:45:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'pt-br', 'problems', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'Como recuperar ou recriar sua senha de administrador?', '2023-02-11 13:45:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_HTTPS_on_your_site', 'user', 'pt-br', 'security', 'enabling-https-on-your-site.md', 'Habilitando o https em seu site', '2023-02-11 13:46:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Getting_Started', 'user', 'pt-br', 'security', 'security-checklist-getting-started.md', 'Lista de verificação de segurança/Primeiros passos', '2023-02-11 13:46:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Hosting_and_Server_Setup', 'user', 'pt-br', 'security', 'security-checklist-hosting-and-server-setup.md', 'Lista de verificação de segurança/Hospedagem e configuração de servidor', '2023-02-11 13:46:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Where_can_you_learn_more_about_file_permissions?', 'user', 'pt-br', 'security', 'security-checklist-where-can-you-learn-more-about-file-permissions-3f.md', 'Lista de verificação de segurança/Onde você pode aprender mais sobre permissões de arquivo?', '2023-02-11 13:46:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Testing_and_Development', 'user', 'pt-br', 'security', 'security-checklist-testing-and-development.md', 'Lista de verificação de segurança/Testes e desenvolvimento', '2023-02-11 13:46:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Joomla!_Setup', 'user', 'pt-br', 'security', 'security-checklist-joomla-setup.md', 'Lista de verificação/configuração de segurança do Joomla!', '2023-02-11 13:46:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Site_Administration', 'user', 'pt-br', 'security', 'security-checklist-site-administration.md', 'Lista de verificação de segurança/Administração de sites', '2023-02-11 13:46:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Security_Checklist/Site_Recovery', 'user', 'pt-br', 'security', 'security-checklist-site-recovery.md', 'Lista de verificação de segurança/Recuperação de site', '2023-02-11 13:46:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Making_your_site_Search_Engine_Friendly', 'user', 'pt-br', 'seo', 'making-your-site-search-engine-friendly.md', 'Tornando seu site amigável aos mecanismos de pesquisa', '2023-02-11 13:46:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Search_Engine_Friendly_URLs', 'user', 'pt-br', 'seo', 'search-engine-friendly-urls.md', 'Localizadores uniformes de recursos (URLs) amigáveis para mecanismos de pesquisas (SEFs)', '2023-02-11 13:46:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_A_Sitemap', 'user', 'pt-br', 'seo', 'using-a-sitemap.md', 'Usando um mapa de sites', '2023-02-11 13:46:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Title_Tag', 'user', 'pt-br', 'seo', 'using-the-title-tag.md', 'Usando a tag de título', '2023-02-11 13:46:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Using_The_Meta_Description', 'user', 'pt-br', 'seo', 'using-the-meta-description.md', 'Usando a meta descrição', '2023-02-11 13:46:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Linking_To_Other_Sites', 'user', 'pt-br', 'seo', 'linking-to-other-sites.md', 'Vinculando a outros sites', '2023-02-11 13:46:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Common_problems_when_enabling_Search_Engine_Friendly_(SEF)_URLs', 'user', 'pt-br', 'seo', 'common-problems-when-enabling-search-engine-friendly-sef-urls.md', 'Problemas comuns ao habilitar localizadores uniformes de recursos (URLs) amigáveis para mecanismos de pesquisas (SEFs)', '2023-02-11 13:46:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs', 'user', 'pt-br', 'seo', 'enabling-search-engine-friendly-sef-urls.md', 'Ativando localizadores uniformes de recursos (URLs) amigáveis para mecanismos de pesquisas (SEFs)', '2023-02-11 13:46:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Apache', 'user', 'pt-br', 'seo', 'enabling-search-engine-friendly-sef-urls-on-apache.md', 'Habilitando URLs amigáveis para mecanismos de pesquisas (SEF) no Apache', '2023-02-11 13:46:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Hiawatha', 'user', 'pt-br', 'seo', 'enabling-search-engine-friendly-sef-urls-on-hiawatha.md', 'Habilitando URLs amigáveis para mecanismos de buscas (SEF) no Hiawatha', '2023-02-11 13:46:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_IIS/IIS7', 'user', 'pt-br', 'seo', 'enabling-search-engine-friendly-sef-urls-on-iis-iis7.md', 'Habilitando URLs amigáveis para mecanismos de pesquisas (SEF) no IIS7', '2023-02-11 13:47:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Enabling_Search_Engine_Friendly_(SEF)_URLs_on_Nginx', 'user', 'pt-br', 'seo', 'enabling-search-engine-friendly-sef-urls-on-nginx.md', 'Habilitando localizadores uniformes de recursos (URLs) amigáveis para mecanismos de buscas (SEFs) no Nginx', '2023-02-11 13:47:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Backup_Basics_for_a_Joomla!_Web_Site', 'user', 'pt-br', 'system', 'backup-basics-for-a-joomla-web-site.md', 'Básico de Cópias de Segurança para um site em Joomla!', '2023-02-11 13:47:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'pt-br', 'users', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'Como recuperar ou recriar sua senha de administrador?', '2023-02-11 13:47:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Workflow', 'user', 'pt-br', 'workflows', 'workflow.md', 'Fluxo de trabalho', '2023-02-11 13:48:00') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'pt', 'articles', 'adding-a-menu-link-in-an-article.md', 'Adicionar uma hiperligação de menu num artigo', '2023-02-11 13:26:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Content_editors', 'user', 'pt', 'editors', 'content-editors.md', 'Editores de conteúdo', '2023-02-11 13:27:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_to_build_your_free_Joomla_Website', 'user', 'pt', 'installation-variations', 'how-to-build-your-free-joomla-website.md', 'Como criar o seu <i>site</i> da Web gratuito Joomla', '2023-02-11 13:28:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Debugging_a_translation', 'user', 'pt', 'languages', 'debugging-a-translation.md', 'Depurar uma tradução', '2023-02-11 13:28:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_a_menu_link_in_an_article', 'user', 'pt', 'menus', 'adding-a-menu-link-in-an-article.md', 'Adicionar uma hiperligação de menu num artigo', '2023-02-11 13:28:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_Migrate', 'user', 'pt', 'migration', 'why-migrate.md', 'Por que migrar', '2023-02-11 13:28:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Potential_backward_compatibility_issues_in_Joomla_4', 'user', 'pt', 'migration', 'potential-backward-compatibility-issues-in-joomla-4.md', 'Possíveis problemas de compatibilidade com as versões anteriores no Joomla 4', '2023-02-11 13:29:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'pt', 'problems', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'Como recuperar ou repor a sua palavra-passe de administrador?', '2023-02-11 13:29:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Search_Engine_Friendly_URLs', 'user', 'pt', 'seo', 'search-engine-friendly-urls.md', 'URLs Amigáveis ​​do Motor de Pesquisa', '2023-02-11 13:30:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Cache', 'user', 'pt', 'system', 'cache.md', 'Cache', '2023-02-11 13:30:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Backup_Basics_for_a_Joomla!_Web_Site', 'user', 'pt', 'system', 'backup-basics-for-a-joomla-web-site.md', 'Elementar das Cópias de Segurança para o Joomla! - Site da
Web', '2023-02-11 13:30:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'pt', 'users', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'Como recuperar ou repor a sua palavra-passe de administrador?', '2023-02-11 13:31:19') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Deleting_an_Article', 'user', 'ru', 'articles', 'deleting-an-article.md', 'Deleting an Article', '2023-02-11 13:48:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Archive_an_Article', 'user', 'ru', 'articles', 'how-to-archive-an-article.md', 'How to Archive an Article', '2023-02-11 13:48:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Adding_an_image_to_an_article', 'user', 'ru', 'articles', 'adding-an-image-to-an-article.md', 'Как добавить изображение в материал', '2023-02-11 13:48:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_convert_an_htaccess.txt_file_into_a_.htaccess_file?', 'user', 'ru', 'configuration', 'how-do-you-convert-an-htaccess-txt-file-into-a-htaccess-file-3f.md', 'Как конвертировать файл htaccess.txt в .htaccess?', '2023-02-11 13:49:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Content_editors', 'user', 'ru', 'editors', 'content-editors.md', 'Редакторы содержимого', '2023-02-11 13:49:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Nginx', 'user', 'ru', 'hosting', 'nginx.md', 'Nginx', '2023-02-11 13:50:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Debugging_a_translation', 'user', 'ru', 'languages', 'debugging-a-translation.md', 'Отладка перевода', '2023-02-11 13:50:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Managing_Media', 'user', 'ru', 'media', 'managing-media.md', 'Managing Media', '2023-02-11 13:50:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Media:_Options', 'user', 'ru', 'media', 'media-options.md', 'Медиа-менеджер: Настройки', '2023-02-11 13:50:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Why_Migrate', 'user', 'ru', 'migration', 'why-migrate.md', 'Зачем мигрировать', '2023-02-11 13:50:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_3.x_to_4.x_Step_by_Step_Migration', 'user', 'ru', 'migration', 'joomla-3-x-to-4-x-step-by-step-migration.md', 'Пошаговая миграция с Joomla 3.x на 4.x', '2023-02-11 13:50:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Migration_Step_by_Step_Self_Assessment', 'user', 'ru', 'migration', 'migration-step-by-step-self-assessment.md', 'Миграция шаг за шагом - Самооценка', '2023-02-11 13:50:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_Migration_-_Joomla_1.5_to_4', 'user', 'ru', 'migration', 'planning-migration-joomla-1-5-to-4.md', 'Планирование миграции - с Joomla 1.5 на 3', '2023-02-11 13:50:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Migration', 'user', 'ru', 'migration', 'planning-for-migration.md', 'Планирование миграции', '2023-02-11 13:51:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Planning_for_Mini-Migration_-_Joomla_3.10.x_to_4.x', 'user', 'ru', 'migration', 'planning-for-mini-migration-joomla-3-10-x-to-4-x.md', 'Планирование мини-миграции - с Joomla 3.10 на 4.x', '2023-02-11 13:51:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Template_Considerations_During_Migration', 'user', 'ru', 'migration', 'template-considerations-during-migration.md', 'Соображения по шаблонам во время миграции', '2023-02-11 13:51:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:How_to_Show_a_Calendar_Month_List_of_Archived_Articles_Using_a_Module', 'user', 'ru', 'modules', 'how-to-show-a-calendar-month-list-of-archived-articles-using-a-module.md', 'How to Show a Calendar Month List of Archived Articles Using a Module', '2023-02-11 13:51:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'ru', 'problems', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'Как восстановить или заново настроить пароль Вашего супер администратора?', '2023-02-11 13:51:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Cache', 'user', 'ru', 'system', 'cache.md', 'Cache', '2023-02-11 13:52:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Backup_Basics_for_a_Joomla!_Web_Site', 'user', 'ru', 'system', 'backup-basics-for-a-joomla-web-site.md', 'Joomla! Основы резервного копирования', '2023-02-11 13:52:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Database_Table_Prefix', 'user', 'ru', 'system', 'database-table-prefix.md', 'Приставка таблиц базы данных', '2023-02-11 13:52:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('How_do_you_recover_or_reset_your_admin_password?', 'user', 'ru', 'users', 'how-do-you-recover-or-reset-your-admin-password-3f.md', 'Как восстановить или заново настроить пароль Вашего супер администратора?', '2023-02-11 13:53:13') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Start_Here', 'help', 'en', 'help-screens', 'start-here.md', 'Start Here', '2023-02-07 07:30:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Action_Logs_-_Latest', 'help', 'en', 'admin-modules', 'admin-modules-action-logs-latest.md', 'Admin Modules: Action Logs - Latest', '2023-02-07 07:30:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Administrator_Dashboard_Menu', 'help', 'en', 'admin-modules', 'admin-modules-administrator-dashboard-menu.md', 'Admin Modules: Administrator Dashboard Menu', '2023-02-07 07:30:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Administrator_Menu', 'help', 'en', 'admin-modules', 'admin-modules-administrator-menu.md', 'Admin Modules: Administrator Menu', '2023-02-07 07:30:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Articles_-_Latest', 'help', 'en', 'admin-modules', 'admin-modules-articles-latest.md', 'Admin Modules: Articles - Latest', '2023-02-07 07:30:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Custom', 'help', 'en', 'admin-modules', 'admin-modules-custom.md', 'Admin Modules: Custom', '2023-02-07 07:30:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Feed_Display', 'help', 'en', 'admin-modules', 'admin-modules-feed-display.md', 'Admin Modules: Feed Display', '2023-02-07 07:30:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Frontend_Link', 'help', 'en', 'admin-modules', 'admin-modules-frontend-link.md', 'Admin Modules: Frontend Link', '2023-02-07 07:30:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Joomla_Version_Information', 'help', 'en', 'admin-modules', 'admin-modules-joomla-version-information.md', 'Admin Modules: Joomla Version Information', '2023-02-07 07:30:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Logged-in_Users', 'help', 'en', 'admin-modules', 'admin-modules-logged-in-users.md', 'Admin Modules: Logged-in Users', '2023-02-07 07:30:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Login_Form', 'help', 'en', 'admin-modules', 'admin-modules-login-form.md', 'Admin Modules: Login Form', '2023-02-07 07:30:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Login_Support_Information', 'help', 'en', 'admin-modules', 'admin-modules-login-support-information.md', 'Admin Modules: Login Support Information', '2023-02-07 07:30:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Messages', 'help', 'en', 'admin-modules', 'admin-modules-messages.md', 'Admin Modules: Messages', '2023-02-07 07:30:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Multilingual_Status', 'help', 'en', 'admin-modules', 'admin-modules-multilingual-status.md', 'Admin Modules: Multilingual Status', '2023-02-07 07:30:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Popular_Articles', 'help', 'en', 'admin-modules', 'admin-modules-popular-articles.md', 'Admin Modules: Popular Articles', '2023-02-07 07:30:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Post_Installation_Messages', 'help', 'en', 'admin-modules', 'admin-modules-post-installation-messages.md', 'Admin Modules: Post Installation Messages', '2023-02-07 07:31:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Privacy_Dashboard', 'help', 'en', 'admin-modules', 'admin-modules-privacy-dashboard.md', 'Admin Modules: Privacy Dashboard', '2023-02-07 07:31:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Privacy_Status_Check', 'help', 'en', 'admin-modules', 'admin-modules-privacy-status-check.md', 'Admin Modules: Privacy Status Check', '2023-02-07 07:31:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Quick_Icons', 'help', 'en', 'admin-modules', 'admin-modules-quick-icons.md', 'Admin Modules: Quick Icons', '2023-02-07 07:31:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Sample_Data', 'help', 'en', 'admin-modules', 'admin-modules-sample-data.md', 'Admin Modules: Sample Data', '2023-02-07 07:31:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Title', 'help', 'en', 'admin-modules', 'admin-modules-title.md', 'Admin Modules: Title', '2023-02-07 07:31:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Toolbar', 'help', 'en', 'admin-modules', 'admin-modules-toolbar.md', 'Admin Modules: Toolbar', '2023-02-07 07:31:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_User_Menu', 'help', 'en', 'admin-modules', 'admin-modules-user-menu.md', 'Admin Modules: User Menu', '2023-02-07 07:31:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles', 'help', 'en', 'articles', 'articles.md', 'Articles', '2023-02-07 07:31:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Categories', 'help', 'en', 'articles', 'articles-categories.md', 'Articles: Categories', '2023-02-07 07:31:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Edit', 'help', 'en', 'articles', 'articles-edit.md', 'Articles: Edit', '2023-02-07 07:31:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Featured', 'help', 'en', 'articles', 'articles-featured.md', 'Articles: Featured', '2023-02-07 07:31:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_New_or_Edit_Category', 'help', 'en', 'articles', 'articles-new-or-edit-category.md', 'Articles: Edit Category', '2023-02-07 07:31:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Options', 'help', 'en', 'articles', 'articles-options.md', 'Articles: Options', '2023-02-07 07:31:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners', 'help', 'en', 'banners', 'banners.md', 'Banners', '2023-02-07 07:31:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Categories', 'help', 'en', 'banners', 'banners-categories.md', 'Banners: Categories', '2023-02-07 07:31:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Clients', 'help', 'en', 'banners', 'banners-clients.md', 'Banners: Clients', '2023-02-07 07:31:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Edit', 'help', 'en', 'banners', 'banners-edit.md', 'Banners: Edit', '2023-02-07 07:31:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_New_or_Edit_Category', 'help', 'en', 'banners', 'banners-new-or-edit-category.md', 'Banners: New or Edit Category', '2023-02-07 07:31:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_New_or_Edit_Client', 'help', 'en', 'banners', 'banners-new-or-edit-client.md', 'Banners: New or Edit Client', '2023-02-07 07:31:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Options', 'help', 'en', 'banners', 'banners-options.md', 'Banners: Options', '2023-02-07 07:31:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Tracks', 'help', 'en', 'banners', 'banners-tracks.md', 'Banners: Tracks', '2023-02-07 07:31:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Cache:_Options', 'help', 'en', 'cache', 'cache-options.md', 'Cache: Options', '2023-02-07 07:31:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Check-in:_Options', 'help', 'en', 'cache', 'check-in-options.md', 'Check-in: Options', '2023-02-07 07:31:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Chunks', 'help', 'en', 'chunks', 'chunks.md', 'Chunks', '2023-02-07 07:32:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Component:_Field_Groups', 'help', 'en', 'component', 'component-field-groups.md', 'Field Groups', '2023-02-07 07:32:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Component:_Fields', 'help', 'en', 'component', 'component-fields.md', 'Fields', '2023-02-07 07:32:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Component:_New_or_Edit_Field', 'help', 'en', 'component', 'component-new-or-edit-field.md', 'Fields: Edit', '2023-02-07 07:32:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Component:_New_or_Edit_Field_Group', 'help', 'en', 'component', 'component-new-or-edit-field-group.md', 'Field Groups: Edit', '2023-02-07 07:32:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Banners_Banners_Edit', 'help', 'en', 'components', 'components-banners-banners-edit.md', 'Banners: Edit', '2023-02-07 07:32:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Banners_Banners_Options', 'help', 'en', 'components', 'components-banners-banners-options.md', 'Components Banners Banners Options', '2023-02-07 07:32:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Check-in_Configuration', 'help', 'en', 'components', 'components-check-in-configuration.md', 'Components Check-in Configuration', '2023-02-07 07:32:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Patch_Tester_Options', 'help', 'en', 'components', 'components-patch-tester-options.md', 'Components Patch Tester Options', '2023-02-07 07:32:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Plug-in_Manager_Options', 'help', 'en', 'components', 'components-plug-in-manager-options.md', 'Components Plug-in Manager Options', '2023-02-07 07:32:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Privacy_Outline', 'help', 'en', 'components', 'components-privacy-outline.md', 'Components Privacy Outline', '2023-02-07 07:32:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Redirect_Manager', 'help', 'en', 'components', 'components-redirect-manager.md', 'Redirects: Links', '2023-02-07 07:32:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Search', 'help', 'en', 'components', 'components-search.md', 'Components Search', '2023-02-07 07:32:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Search_Manager_Options', 'help', 'en', 'components', 'components-search-manager-options.md', 'Components Search Manager Options', '2023-02-07 07:32:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Version_History', 'help', 'en', 'components', 'components-version-history.md', 'Components Version History', '2023-02-07 07:32:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Web_Links_Manager_Options', 'help', 'en', 'components', 'components-web-links-manager-options.md', 'Components Web Links Manager Options', '2023-02-07 07:32:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Weblinks_Categories', 'help', 'en', 'components', 'components-weblinks-categories.md', 'Components Weblinks Categories', '2023-02-07 07:32:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Weblinks_Categories_Edit', 'help', 'en', 'components', 'components-weblinks-categories-edit.md', 'Components Weblinks Categories Edit', '2023-02-07 07:32:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Weblinks_Links', 'help', 'en', 'components', 'components-weblinks-links.md', 'Components Weblinks Links', '2023-02-07 07:32:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Weblinks_Links_Edit', 'help', 'en', 'components', 'components-weblinks-links-edit.md', 'Components Weblinks Links Edit', '2023-02-07 07:32:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts', 'help', 'en', 'contacts', 'contacts.md', 'Contacts', '2023-02-07 07:32:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts:_Categories', 'help', 'en', 'contacts', 'contacts-categories.md', 'Contacts: Categories', '2023-02-07 07:33:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts:_New_or_Edit', 'help', 'en', 'contacts', 'contacts-new-or-edit.md', 'Contacts: Edit', '2023-02-07 07:33:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts:_New_or_Edit_Category', 'help', 'en', 'contacts', 'contacts-new-or-edit-category.md', 'Contacts: Edit Category', '2023-02-07 07:33:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts:_Options', 'help', 'en', 'contacts', 'contacts-options.md', 'Contacts: Options', '2023-02-07 07:33:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Content_Security_Policy:_Options', 'help', 'en', 'content-security-policy', 'content-security-policy-options.md', 'Content Security Policy: Options', '2023-02-07 07:33:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Content_Security_Policy_Reports', 'help', 'en', 'content-security-policy', 'content-security-policy-reports.md', 'Content Security Policy Reports', '2023-02-07 07:33:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Editors', 'help', 'en', 'editors', 'editors.md', 'Editors', '2023-02-07 07:33:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:TinyMCE', 'help', 'en', 'editors', 'tinymce.md', 'TinyMCE', '2023-02-07 07:33:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Discover', 'help', 'en', 'extensions', 'extensions-discover.md', 'Extensions: Discover', '2023-02-07 07:33:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Install', 'help', 'en', 'extensions', 'extensions-install.md', 'Extensions: Install', '2023-02-07 07:33:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Languages', 'help', 'en', 'extensions', 'extensions-languages.md', 'Extensions: Languages', '2023-02-07 07:33:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Manage', 'help', 'en', 'extensions', 'extensions-manage.md', 'Extensions: Manage', '2023-02-07 07:33:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Update', 'help', 'en', 'extensions', 'extensions-update.md', 'Extensions: Update', '2023-02-07 07:33:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Extension_Manager_Languages', 'help', 'en', 'extensions', 'extensions-extension-manager-languages.md', 'Extensions Extension Manager Languages', '2023-02-07 07:33:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Module_Manager_Admin_Status_Unused', 'help', 'en', 'extensions', 'extensions-module-manager-admin-status-unused.md', 'Extensions Module Manager Admin Status Unused', '2023-02-07 07:33:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Module_Manager_Articles_Categories', 'help', 'en', 'extensions', 'extensions-module-manager-articles-categories.md', 'Site Modules: Articles - Categories', '2023-02-07 07:33:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Module_Manager_Edit', 'help', 'en', 'extensions', 'extensions-module-manager-edit.md', 'Extensions Module Manager Edit', '2023-02-07 07:33:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Module_Manager_Sample_Data', 'help', 'en', 'extensions', 'extensions-module-manager-sample-data.md', 'Extensions Module Manager Sample Data', '2023-02-07 07:33:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Module_Manager_Weblinks', 'help', 'en', 'extensions', 'extensions-module-manager-weblinks.md', 'Extensions Module Manager Weblinks', '2023-02-07 07:33:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Modules_Administrator', 'help', 'en', 'extensions', 'extensions-modules-administrator.md', 'Extensions Modules Administrator', '2023-02-07 07:33:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Fields:_Edit', 'help', 'en', 'fields', 'fields-edit.md', 'Fields: Edit', '2023-02-07 07:33:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Glossary', 'help', 'en', 'glossary', 'glossary.md', 'Glossary', '2023-02-07 07:33:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Help_screens_styleguide', 'help', 'en', 'help-screens', 'help-screens-styleguide.md', 'Help screens styleguide', '2023-02-07 07:33:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Information:_Database', 'help', 'en', 'information', 'information-database.md', 'Information: Database', '2023-02-07 07:34:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Information:_Warnings', 'help', 'en', 'information', 'information-warnings.md', 'Information: Warnings', '2023-02-07 07:34:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Installer:_Options', 'help', 'en', 'install-or-update', 'installer-options.md', 'Installer: Options', '2023-02-07 07:34:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Update', 'help', 'en', 'install-or-update', 'joomla-update.md', 'Joomla Update', '2023-02-07 07:34:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Update:_Options', 'help', 'en', 'install-or-update', 'joomla-update-options.md', 'Joomla Update: Options', '2023-02-07 07:34:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_4_0_0', 'help', 'en', 'install-or-update', 'joomla-version-4-0-0.md', 'Joomla Version 4 0 0', '2023-02-07 07:34:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_4_0_1', 'help', 'en', 'install-or-update', 'joomla-version-4-0-1.md', 'Joomla Version 4 0 1', '2023-02-07 07:34:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_4_0_2', 'help', 'en', 'install-or-update', 'joomla-version-4-0-2.md', 'Joomla Version 4 0 2', '2023-02-07 07:34:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_4_0_3', 'help', 'en', 'install-or-update', 'joomla-version-4-0-3.md', 'Joomla Version 4 0 3', '2023-02-07 07:34:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_4_0_4', 'help', 'en', 'install-or-update', 'joomla-version-4-0-4.md', 'Joomla Version 4 0 4', '2023-02-07 07:34:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_Additional_Information', 'help', 'en', 'install-or-update', 'joomla-version-additional-information.md', 'Joomla Version Additional Information', '2023-02-07 07:34:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_Information', 'help', 'en', 'install-or-update', 'joomla-version-information.md', 'Joomla Version Information', '2023-02-07 07:34:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Content', 'help', 'en', 'languages', 'languages-content.md', 'Languages: Content', '2023-02-07 07:34:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Edit_Content_Language', 'help', 'en', 'languages', 'languages-edit-content-language.md', 'Languages: Edit Content Language', '2023-02-07 07:34:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Edit_Override', 'help', 'en', 'languages', 'languages-edit-override.md', 'Languages: Edit Override', '2023-02-07 07:34:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Installed', 'help', 'en', 'languages', 'languages-installed.md', 'Languages: Installed', '2023-02-07 07:34:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Options', 'help', 'en', 'languages', 'languages-options.md', 'Languages: Options', '2023-02-07 07:34:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Overrides', 'help', 'en', 'languages', 'languages-overrides.md', 'Languages: Overrides', '2023-02-07 07:34:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Mail_Template:_Edit', 'help', 'en', 'mail', 'mail-template-edit.md', 'Mail Template: Edit', '2023-02-07 07:34:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Mail_Templates', 'help', 'en', 'mail', 'mail-templates.md', 'Mail Templates', '2023-02-07 07:34:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Mail_Templates:_Options', 'help', 'en', 'mail', 'mail-templates-options.md', 'Mail Templates: Options', '2023-02-07 07:34:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Maintenance:_Clear_Cache', 'help', 'en', 'mail', 'maintenance-clear-cache.md', 'Maintenance: Clear Cache', '2023-02-07 07:34:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Maintenance:_Global_Check-in', 'help', 'en', 'mail', 'maintenance-global-check-in.md', 'Maintenance: Global Check-in', '2023-02-07 07:34:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Mass_Mail_Users', 'help', 'en', 'mail', 'mass-mail-users.md', 'Mass Mail Users', '2023-02-07 07:34:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media', 'help', 'en', 'media', 'media.md', 'Media', '2023-02-07 07:34:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media:_Options', 'help', 'en', 'media', 'media-options.md', 'Media: Options', '2023-02-07 07:34:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Alias', 'help', 'en', 'menu-items', 'menu-item-alias.md', 'Menu Item: Alias', '2023-02-07 07:34:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Article_Archived', 'help', 'en', 'menu-items', 'menu-item-article-archived.md', 'Menu Item: Article Archived', '2023-02-07 07:34:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Category_Blog', 'help', 'en', 'menu-items', 'menu-item-category-blog.md', 'Menu Item: Category Blog', '2023-02-07 07:35:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Category_List', 'help', 'en', 'menu-items', 'menu-item-category-list.md', 'Menu Item: Category List', '2023-02-07 07:35:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Compact_List_of_Tagged_Items', 'help', 'en', 'menu-items', 'menu-item-compact-list-of-tagged-items.md', 'Menu Item: Compact List of Tagged Items', '2023-02-07 07:35:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Components_Menu_Container', 'help', 'en', 'menu-items', 'menu-item-components-menu-container.md', 'Menu Item: Components Menu Container', '2023-02-07 07:35:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Confirm_Request', 'help', 'en', 'menu-items', 'menu-item-confirm-request.md', 'Menu Item: Confirm Request', '2023-02-07 07:35:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Create_Article', 'help', 'en', 'menu-items', 'menu-item-create-article.md', 'Menu Item: Create Article', '2023-02-07 07:35:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Create_Contact', 'help', 'en', 'menu-items', 'menu-item-create-contact.md', 'Menu Item: Create Contact', '2023-02-07 07:35:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Create_Request', 'help', 'en', 'menu-items', 'menu-item-create-request.md', 'Menu Item: Create Request', '2023-02-07 07:35:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Display_Template_Options', 'help', 'en', 'menu-items', 'menu-item-display-template-options.md', 'Menu Item: Display Template Options', '2023-02-07 07:35:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Edit_User_Profile', 'help', 'en', 'menu-items', 'menu-item-edit-user-profile.md', 'Menu Item: Edit User Profile', '2023-02-07 07:35:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Extend_Consent', 'help', 'en', 'menu-items', 'menu-item-extend-consent.md', 'Menu Item: Extend Consent', '2023-02-07 07:35:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Featured_Articles', 'help', 'en', 'menu-items', 'menu-item-featured-articles.md', 'Menu Item: Featured Articles', '2023-02-07 07:35:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Featured_Contacts', 'help', 'en', 'menu-items', 'menu-item-featured-contacts.md', 'Menu Item: Featured Contacts', '2023-02-07 07:35:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Heading', 'help', 'en', 'menu-items', 'menu-item-heading.md', 'Menu Item: Heading', '2023-02-07 07:35:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Iframe_Wrapper', 'help', 'en', 'menu-items', 'menu-item-iframe-wrapper.md', 'Menu Item: Iframe Wrapper', '2023-02-07 07:35:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_All_Categories', 'help', 'en', 'menu-items', 'menu-item-list-all-categories.md', 'Menu Item: List All Categories', '2023-02-07 07:35:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_All_Contact_Categories', 'help', 'en', 'menu-items', 'menu-item-list-all-contact-categories.md', 'Menu Item: List All Contact Categories', '2023-02-07 07:35:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_All_News_Feed_Categories', 'help', 'en', 'menu-items', 'menu-item-list-all-news-feed-categories.md', 'Menu Item: List All News Feed Categories', '2023-02-07 07:35:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_All_Tags', 'help', 'en', 'menu-items', 'menu-item-list-all-tags.md', 'Menu Item: List All Tags', '2023-02-07 07:35:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_Contacts_in_a_Category', 'help', 'en', 'menu-items', 'menu-item-list-contacts-in-a-category.md', 'Menu Item: List Contacts in a Category', '2023-02-07 07:35:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_News_Feeds_in_a_Category', 'help', 'en', 'menu-items', 'menu-item-list-news-feeds-in-a-category.md', 'Menu Item: List News Feeds in a Category', '2023-02-07 07:35:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Login_Form', 'help', 'en', 'menu-items', 'menu-item-login-form.md', 'Menu Item: Login Form', '2023-02-07 07:36:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Logout', 'help', 'en', 'menu-items', 'menu-item-logout.md', 'Menu Item: Logout', '2023-02-07 07:36:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_New_Item', 'help', 'en', 'menu-items', 'menu-item-new-item.md', 'Menu Item: New Item', '2023-02-07 07:36:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Password_Reset', 'help', 'en', 'menu-items', 'menu-item-password-reset.md', 'Menu Item: Password Reset', '2023-02-07 07:36:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Registration_Form', 'help', 'en', 'menu-items', 'menu-item-registration-form.md', 'Menu Item: Registration Form', '2023-02-07 07:36:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Search', 'help', 'en', 'menu-items', 'menu-item-search.md', 'Menu Item: Search', '2023-02-07 07:36:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Separator', 'help', 'en', 'menu-items', 'menu-item-separator.md', 'Menu Item: Separator', '2023-02-07 07:36:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Single_Article', 'help', 'en', 'menu-items', 'menu-item-single-article.md', 'Menu Item: Single Article', '2023-02-07 07:36:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Single_Contact', 'help', 'en', 'menu-items', 'menu-item-single-contact.md', 'Menu Item: Single Contact', '2023-02-07 07:36:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Single_News_Feed', 'help', 'en', 'menu-items', 'menu-item-single-news-feed.md', 'Menu Item: Single News Feed', '2023-02-07 07:36:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Site_Configuration_Options', 'help', 'en', 'menu-items', 'menu-item-site-configuration-options.md', 'Menu Item: Site Configuration Options', '2023-02-07 07:36:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Tagged_Items', 'help', 'en', 'menu-items', 'menu-item-tagged-items.md', 'Menu Item: Tagged Items', '2023-02-07 07:36:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_URL', 'help', 'en', 'menu-items', 'menu-item-url.md', 'Menu Item: URL', '2023-02-07 07:36:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_User_Profile', 'help', 'en', 'menu-items', 'menu-item-user-profile.md', 'Menu Item: User Profile', '2023-02-07 07:36:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Username_Reminder_Request', 'help', 'en', 'menu-items', 'menu-item-username-reminder-request.md', 'Menu Item: Username Reminder Request', '2023-02-07 07:36:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus', 'help', 'en', 'menus', 'menus.md', 'Menus', '2023-02-07 07:36:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Edit', 'help', 'en', 'menus', 'menus-edit.md', 'Menus: Edit', '2023-02-07 07:36:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Items', 'help', 'en', 'menus', 'menus-items.md', 'Menus: Items', '2023-02-07 07:36:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Options', 'help', 'en', 'menus', 'menus-options.md', 'Menus: Options', '2023-02-07 07:36:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus_Menu_Item_Search_Results', 'help', 'en', 'menus', 'menus-menu-item-search-results.md', 'Menus Menu Item Search Results', '2023-02-07 07:36:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus_Menu_Item_Weblink_Categories', 'help', 'en', 'menus', 'menus-menu-item-weblink-categories.md', 'Menus Menu Item Weblink Categories', '2023-02-07 07:36:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus_Menu_Item_Weblink_Category', 'help', 'en', 'menus', 'menus-menu-item-weblink-category.md', 'Menus Menu Item Weblink Category', '2023-02-07 07:36:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus_Menu_Item_Weblink_Submit', 'help', 'en', 'menus', 'menus-menu-item-weblink-submit.md', 'Menus Menu Item Weblink Submit', '2023-02-07 07:36:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus_Menu_Manager_Options', 'help', 'en', 'menus', 'menus-menu-manager-options.md', 'Menus Menu Manager Options', '2023-02-07 07:37:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Messages:_Options', 'help', 'en', 'messages', 'messages-options.md', 'Messages: Options', '2023-02-07 07:37:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Module:_Options', 'help', 'en', 'modules', 'module-options.md', 'Modules: Options', '2023-02-07 07:37:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Modules', 'help', 'en', 'modules', 'modules.md', 'Modules', '2023-02-07 07:37:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations', 'help', 'en', 'multilingual-associations', 'multilingual-associations.md', 'Multilingual Associations', '2023-02-07 07:37:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Edit', 'help', 'en', 'multilingual-associations', 'multilingual-associations-edit.md', 'Multilingual Associations: Edit', '2023-02-07 07:37:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Options', 'help', 'en', 'multilingual-associations', 'multilingual-associations-options.md', 'Multilingual Associations: Options', '2023-02-07 07:37:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:My_Profile', 'help', 'en', 'my-profile', 'my-profile.md', 'My Profile', '2023-02-07 07:37:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:News_Feed:_Options', 'help', 'en', 'news-feed', 'news-feed-options.md', 'News Feed: Options', '2023-02-07 07:37:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:News_Feeds', 'help', 'en', 'news-feed', 'news-feeds.md', 'News Feeds', '2023-02-07 07:37:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:News_Feeds:_Categories', 'help', 'en', 'news-feed', 'news-feeds-categories.md', 'News Feeds: Categories', '2023-02-07 07:37:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:News_Feeds:_New_or_Edit', 'help', 'en', 'news-feed', 'news-feeds-new-or-edit.md', 'News Feeds: Edit', '2023-02-07 07:37:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:News_Feeds:_New_or_Edit_Category', 'help', 'en', 'news-feed', 'news-feeds-new-or-edit-category.md', 'News Feeds: Edit Category', '2023-02-07 07:37:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Permissions_for_Group', 'help', 'en', 'permissions', 'permissions-for-group.md', 'Permissions for Group', '2023-02-07 07:37:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Permissions_for_User', 'help', 'en', 'permissions', 'permissions-for-user.md', 'Permissions for User', '2023-02-07 07:37:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Plugin:_Options', 'help', 'en', 'plugins', 'plugin-options.md', 'Plugin: Options', '2023-02-07 07:37:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Plugins', 'help', 'en', 'plugins', 'plugins.md', 'Plugins', '2023-02-07 07:37:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Plugins:_Name_of_Plugin', 'help', 'en', 'plugins', 'plugins-name-of-plugin.md', 'Plugins: Name of Plugin', '2023-02-07 07:37:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Post-installation_Messages:_Options', 'help', 'en', 'post-install-messages', 'post-installation-messages-options.md', 'Post-installation Messages: Options', '2023-02-07 07:37:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Post-installation_Messages_for_Joomla_CMS', 'help', 'en', 'post-install-messages', 'post-installation-messages-for-joomla-cms.md', 'Post-installation Messages for Joomla CMS', '2023-02-07 07:37:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_Consents', 'help', 'en', 'privacy', 'privacy-consents.md', 'Privacy: Consents', '2023-02-07 07:37:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_Extension_Capabilities', 'help', 'en', 'privacy', 'privacy-extension-capabilities.md', 'Privacy: Extension Capabilities', '2023-02-07 07:37:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_Information_Requests', 'help', 'en', 'privacy', 'privacy-information-requests.md', 'Privacy: Information Requests', '2023-02-07 07:37:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_New_Information_Request', 'help', 'en', 'privacy', 'privacy-new-information-request.md', 'Privacy: New Information Request', '2023-02-07 07:37:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_Options', 'help', 'en', 'privacy', 'privacy-options.md', 'Privacy: Options', '2023-02-07 07:37:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_Review_Information_Request', 'help', 'en', 'privacy', 'privacy-review-information-request.md', 'Privacy: Review Information Request', '2023-02-07 07:38:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy_Dashboard', 'help', 'en', 'privacy', 'privacy-dashboard.md', 'Privacy Dashboard', '2023-02-07 07:38:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Private_Messages', 'help', 'en', 'privacy', 'private-messages.md', 'Private Messages', '2023-02-07 07:38:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Private_Messages:_Read', 'help', 'en', 'private-messages', 'private-messages-read.md', 'Private Messages: Read', '2023-02-07 07:38:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Private_Messages:_Write', 'help', 'en', 'private-messages', 'private-messages-write.md', 'Private Messages: Write', '2023-02-07 07:38:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Redirect:_Options', 'help', 'en', 'redirect', 'redirect-options.md', 'Redirect: Options', '2023-02-07 07:38:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Redirects:_Links', 'help', 'en', 'redirect', 'redirects-links.md', 'Redirects: Links', '2023-02-07 07:38:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Redirects:_New_or_Edit', 'help', 'en', 'redirect', 'redirects-new-or-edit.md', 'Redirects: New or Edit', '2023-02-07 07:38:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Control_Panel', 'help', 'en', 'site', 'site-control-panel.md', 'Home Dashboard', '2023-02-07 07:38:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration', 'help', 'en', 'site', 'site-global-configuration.md', 'Site Global Configuration', '2023-02-07 07:38:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Logging', 'help', 'en', 'site', 'site-global-configuration-logging.md', 'Site Global Configuration Logging', '2023-02-07 07:38:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Permissions', 'help', 'en', 'site', 'site-global-configuration-permissions.md', 'Site Global Configuration Permissions', '2023-02-07 07:38:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Server', 'help', 'en', 'site', 'site-global-configuration-server.md', 'Site Global Configuration Server', '2023-02-07 07:38:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Site', 'help', 'en', 'site', 'site-global-configuration-site.md', 'Site Global Configuration Site', '2023-02-07 07:38:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_System', 'help', 'en', 'site', 'site-global-configuration-system.md', 'Site Global Configuration System', '2023-02-07 07:38:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Text_Filters', 'help', 'en', 'site', 'site-global-configuration-text-filters.md', 'Site Global Configuration Text Filters', '2023-02-07 07:38:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_System_Information', 'help', 'en', 'site', 'site-system-information.md', 'Site System Information', '2023-02-07 07:38:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Archived', 'help', 'en', 'site-modules', 'site-modules-articles-archived.md', 'Site Modules: Articles - Archived', '2023-02-07 07:38:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Categories', 'help', 'en', 'site-modules', 'site-modules-articles-categories.md', 'Site Modules: Articles - Categories', '2023-02-07 07:38:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Category', 'help', 'en', 'site-modules', 'site-modules-articles-category.md', 'Site Modules: Articles - Category', '2023-02-07 07:38:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Latest', 'help', 'en', 'site-modules', 'site-modules-articles-latest.md', 'Site Modules: Articles - Latest', '2023-02-07 07:38:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Most_Read', 'help', 'en', 'site-modules', 'site-modules-articles-most-read.md', 'Site Modules: Articles - Most Read', '2023-02-07 07:38:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Newsflash', 'help', 'en', 'site-modules', 'site-modules-articles-newsflash.md', 'Site Modules: Articles - Newsflash', '2023-02-07 07:38:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Related', 'help', 'en', 'site-modules', 'site-modules-articles-related.md', 'Site Modules: Articles - Related', '2023-02-07 07:38:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Banners', 'help', 'en', 'site-modules', 'site-modules-banners.md', 'Site Modules: Banners', '2023-02-07 07:38:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Breadcrumbs', 'help', 'en', 'site-modules', 'site-modules-breadcrumbs.md', 'Site Modules: Breadcrumbs', '2023-02-07 07:39:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Custom', 'help', 'en', 'site-modules', 'site-modules-custom.md', 'Site Modules: Custom', '2023-02-07 07:39:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Feed_Display', 'help', 'en', 'site-modules', 'site-modules-feed-display.md', 'Site Modules: Feed Display', '2023-02-07 07:39:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Footer', 'help', 'en', 'site-modules', 'site-modules-footer.md', 'Site Modules: Footer', '2023-02-07 07:39:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Language_Switcher', 'help', 'en', 'site-modules', 'site-modules-language-switcher.md', 'Site Modules: Language Switcher', '2023-02-07 07:39:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Latest_Users', 'help', 'en', 'site-modules', 'site-modules-latest-users.md', 'Site Modules: Latest Users', '2023-02-07 07:39:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Login', 'help', 'en', 'site-modules', 'site-modules-login.md', 'Site Modules: Login', '2023-02-07 07:39:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Menu', 'help', 'en', 'site-modules', 'site-modules-menu.md', 'Site Modules: Menu', '2023-02-07 07:39:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Random_Image', 'help', 'en', 'site-modules', 'site-modules-random-image.md', 'Site Modules: Random Image', '2023-02-07 07:39:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Smart_Search', 'help', 'en', 'site-modules', 'site-modules-smart-search.md', 'Site Modules: Smart Search', '2023-02-07 07:39:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Statistics', 'help', 'en', 'site-modules', 'site-modules-statistics.md', 'Site Modules: Statistics', '2023-02-07 07:39:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Syndication_Feeds', 'help', 'en', 'site-modules', 'site-modules-syndication-feeds.md', 'Site Modules: Syndication Feeds', '2023-02-07 07:39:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Tags_-_Popular', 'help', 'en', 'site-modules', 'site-modules-tags-popular.md', 'Site Modules: Tags - Popular', '2023-02-07 07:39:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Tags_-_Similar', 'help', 'en', 'site-modules', 'site-modules-tags-similar.md', 'Site Modules: Tags - Similar', '2023-02-07 07:39:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Who''s_Online', 'help', 'en', 'site-modules', 'site-modules-whos-online.md', 'Site Modules: Who''s Online', '2023-02-07 07:39:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Wrapper', 'help', 'en', 'site-modules', 'site-modules-wrapper.md', 'Site Modules: Wrapper', '2023-02-07 07:39:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Content_Maps', 'help', 'en', 'smart-search', 'smart-search-content-maps.md', 'Smart Search: Content Maps', '2023-02-07 07:39:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Indexed_Content', 'help', 'en', 'smart-search', 'smart-search-indexed-content.md', 'Smart Search: Indexed Content', '2023-02-07 07:39:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_New_or_Edit_Filter', 'help', 'en', 'smart-search', 'smart-search-new-or-edit-filter.md', 'Smart Search: New or Edit Filter', '2023-02-07 07:39:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Options', 'help', 'en', 'smart-search', 'smart-search-options.md', 'Smart Search: Options', '2023-02-07 07:39:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Search_Filters', 'help', 'en', 'smart-search', 'smart-search-search-filters.md', 'Smart Search: Search Filters', '2023-02-07 07:39:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Search_Term_Analysis', 'help', 'en', 'smart-search', 'smart-search-search-term-analysis.md', 'Smart Search: Search Term Analysis', '2023-02-07 07:39:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Tags', 'help', 'en', 'tags', 'tags.md', 'Tags', '2023-02-07 07:39:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Tags:_New_or_Edit', 'help', 'en', 'tags', 'tags-new-or-edit.md', 'Tags: New or Edit', '2023-02-07 07:39:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Tags:_Options', 'help', 'en', 'tags', 'tags-options.md', 'Tags: Options', '2023-02-07 07:39:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Template:_Options', 'help', 'en', 'templates', 'template-options.md', 'Template: Options', '2023-02-07 07:40:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Customise', 'help', 'en', 'templates', 'templates-customise.md', 'Templates: Customise', '2023-02-07 07:40:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Customise_Source', 'help', 'en', 'templates', 'templates-customise-source.md', 'Templates: Customise Source', '2023-02-07 07:40:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Edit_Style', 'help', 'en', 'templates', 'templates-edit-style.md', 'Templates: Edit Style', '2023-02-07 07:40:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Styles', 'help', 'en', 'templates', 'templates-styles.md', 'Templates: Styles', '2023-02-07 07:40:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Templates', 'help', 'en', 'templates', 'templates-templates.md', 'Templates: Templates', '2023-02-07 07:40:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Stages_List:_Basic_Workflow', 'help', 'en', 'workflow', 'stages-list-basic-workflow.md', 'Stages List: Basic Workflow', '2023-02-07 07:40:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Transitions_List:_Basic_Workflow', 'help', 'en', 'workflow', 'transitions-list-basic-workflow.md', 'Transitions List: Basic Workflow', '2023-02-07 07:40:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Workflows_List', 'help', 'en', 'workflow', 'workflows-list.md', 'Workflows List', '2023-02-07 07:40:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Edit_Update_Site', 'help', 'en', 'update-sites', 'edit-update-site.md', 'Edit Update Site', '2023-02-07 07:40:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Update_Sites', 'help', 'en', 'update-sites', 'extensions-update-sites.md', 'Extensions: Update Sites', '2023-02-07 07:40:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Actions_Log', 'help', 'en', 'users', 'user-actions-log.md', 'User Actions Log', '2023-02-07 07:40:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Actions_Log:_Options', 'help', 'en', 'users', 'user-actions-log-options.md', 'User Actions Log: Options', '2023-02-07 07:40:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes', 'help', 'en', 'users', 'user-notes.md', 'User Notes', '2023-02-07 07:40:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes:_Categories', 'help', 'en', 'users', 'user-notes-categories.md', 'User Notes: Categories', '2023-02-07 07:40:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes:_New_or_Edit', 'help', 'en', 'users', 'user-notes-new-or-edit.md', 'User Notes: New or Edit', '2023-02-07 07:40:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes:_New_or_Edit_Category', 'help', 'en', 'users', 'user-notes-new-or-edit-category.md', 'User Notes: New or Edit Category', '2023-02-07 07:40:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users', 'help', 'en', 'users', 'users.md', 'Users', '2023-02-07 07:40:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Edit_Profile', 'help', 'en', 'users', 'users-edit-profile.md', 'Users: Edit Profile', '2023-02-07 07:40:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Edit_Viewing_Access_Level', 'help', 'en', 'users', 'users-edit-viewing-access-level.md', 'Users: Edit Viewing Access Level', '2023-02-07 07:40:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Groups', 'help', 'en', 'users', 'users-groups.md', 'Users: Groups', '2023-02-07 07:40:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_New_or_Edit_Group', 'help', 'en', 'users', 'users-new-or-edit-group.md', 'Users: New or Edit Group', '2023-02-07 07:40:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Options', 'help', 'en', 'users', 'users-options.md', 'Users: Options', '2023-02-07 07:41:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Viewing_Access_Levels', 'help', 'en', 'users', 'users-viewing-access-levels.md', 'Users: Viewing Access Levels', '2023-02-07 07:41:03') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Start_Here', 'help', 'de', 'help-screens', 'start-here.md', 'Hier beginnen', '2023-02-11 13:53:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles', 'help', 'de', 'articles', 'articles.md', 'Beiträge', '2023-02-11 13:54:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Categories', 'help', 'de', 'articles', 'articles-categories.md', 'Beiträge: Kategorien', '2023-02-11 13:54:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Edit', 'help', 'de', 'articles', 'articles-edit.md', 'Beiträge: Bearbeiten', '2023-02-11 13:54:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Featured', 'help', 'de', 'articles', 'articles-featured.md', 'Beiträge: Hauptbeiträge', '2023-02-11 13:54:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Options', 'help', 'de', 'articles', 'articles-options.md', 'Beiträge: Optionen', '2023-02-11 13:54:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners', 'help', 'de', 'banners', 'banners.md', 'Banner', '2023-02-11 13:54:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Categories', 'help', 'de', 'banners', 'banners-categories.md', 'Banner: Kategorien', '2023-02-11 13:54:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Edit', 'help', 'de', 'banners', 'banners-edit.md', 'Banner: Bearbeiten', '2023-02-11 13:54:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_New_or_Edit_Client', 'help', 'de', 'banners', 'banners-new-or-edit-client.md', 'Banner: Kunden bearbeiten', '2023-02-11 13:54:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Version_History', 'help', 'de', 'components', 'components-version-history.md', 'Versionsverlauf', '2023-02-11 13:54:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts', 'help', 'de', 'contacts', 'contacts.md', 'Kontakte', '2023-02-11 13:54:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts:_Categories', 'help', 'de', 'contacts', 'contacts-categories.md', 'Kontakte: Kategorien', '2023-02-11 13:55:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts:_Options', 'help', 'de', 'contacts', 'contacts-options.md', 'Kontakte: Optionen', '2023-02-11 13:55:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Editors', 'help', 'de', 'editors', 'editors.md', 'Editoren', '2023-02-11 13:55:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:TinyMCE', 'help', 'de', 'editors', 'tinymce.md', 'TinyMCE', '2023-02-11 13:55:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Discover', 'help', 'de', 'extensions', 'extensions-discover.md', 'Erweiterungen: Überprüfen', '2023-02-11 13:55:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Install', 'help', 'de', 'extensions', 'extensions-install.md', 'Erweiterungen: Installieren', '2023-02-11 13:55:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Languages', 'help', 'de', 'extensions', 'extensions-languages.md', 'Erweiterungen: Sprachen installieren', '2023-02-11 13:55:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Manage', 'help', 'de', 'extensions', 'extensions-manage.md', 'Erweiterungen: Verwalten', '2023-02-11 13:55:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Update', 'help', 'de', 'extensions', 'extensions-update.md', 'Erweiterungen: Aktualisieren', '2023-02-11 13:55:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Extension_Manager_Languages', 'help', 'de', 'extensions', 'extensions-extension-manager-languages.md', 'Erweiterungen: Sprachen installieren', '2023-02-11 13:55:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Module_Manager_Articles_Categories', 'help', 'de', 'extensions', 'extensions-module-manager-articles-categories.md', 'Site-Modul: Beiträge – Kategorien', '2023-02-11 13:55:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Module_Manager_Edit', 'help', 'de', 'extensions', 'extensions-module-manager-edit.md', 'Erweiterungen: Module bearbeiten', '2023-02-11 13:55:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Module_Manager_Sample_Data', 'help', 'de', 'extensions', 'extensions-module-manager-sample-data.md', 'Erweiterungen: Module Beispieldaten', '2023-02-11 13:55:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Fields:_Edit', 'help', 'de', 'fields', 'fields-edit.md', 'Felder: Bearbeiten', '2023-02-11 13:55:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Information:_Database', 'help', 'de', 'information', 'information-database.md', 'Information: Datenbank', '2023-02-11 13:55:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Information:_Warnings', 'help', 'de', 'information', 'information-warnings.md', 'Information: Warnungen', '2023-02-11 13:55:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_4_0_3', 'help', 'de', 'install-or-update', 'joomla-version-4-0-3.md', 'Joomla Version 4.0.3', '2023-02-11 13:55:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_Additional_Information', 'help', 'de', 'install-or-update', 'joomla-version-additional-information.md', 'Ergänzende Joomla Versionsinformationen', '2023-02-11 13:55:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_Information', 'help', 'de', 'install-or-update', 'joomla-version-information.md', 'Joomla! Versions-Informationen', '2023-02-11 13:55:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Installed', 'help', 'de', 'languages', 'languages-installed.md', 'Sprachen: Installiert', '2023-02-11 13:56:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Options', 'help', 'de', 'languages', 'languages-options.md', 'Sprachen: Optionen', '2023-02-11 13:56:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Overrides', 'help', 'de', 'languages', 'languages-overrides.md', 'Sprachen: Overrides', '2023-02-11 13:56:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Maintenance:_Clear_Cache', 'help', 'de', 'mail', 'maintenance-clear-cache.md', 'Wartung: Cache leeren', '2023-02-11 13:56:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Maintenance:_Global_Check-in', 'help', 'de', 'mail', 'maintenance-global-check-in.md', 'Wartung: Globales Freigeben', '2023-02-11 13:56:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Mass_Mail_Users', 'help', 'de', 'mail', 'mass-mail-users.md', 'Serien-Mail an Benutzer', '2023-02-11 13:56:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media', 'help', 'de', 'media', 'media.md', 'Medien', '2023-02-11 13:56:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media:_Options', 'help', 'de', 'media', 'media-options.md', 'Medien: Optionen', '2023-02-11 13:56:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Article_Archived', 'help', 'de', 'menu-items', 'menu-item-article-archived.md', 'Menüeintrag: Archivierte Beiträge', '2023-02-11 13:56:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Category_Blog', 'help', 'de', 'menu-items', 'menu-item-category-blog.md', 'Menüeintrag: Kategorieblog', '2023-02-11 13:56:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Category_List', 'help', 'de', 'menu-items', 'menu-item-category-list.md', 'Menüeintrag: Kategorieliste', '2023-02-11 13:56:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Create_Article', 'help', 'de', 'menu-items', 'menu-item-create-article.md', 'Menüeintrag: Beitrag erstellen', '2023-02-11 13:56:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Create_Contact', 'help', 'de', 'menu-items', 'menu-item-create-contact.md', 'Menüpunkt: Kontakt erstellen', '2023-02-11 13:56:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Display_Template_Options', 'help', 'de', 'menu-items', 'menu-item-display-template-options.md', 'Menüeintrag Template-Optionen', '2023-02-11 13:56:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Edit_User_Profile', 'help', 'de', 'menu-items', 'menu-item-edit-user-profile.md', 'Menüeintrag: Benutzerprofil bearbeiten', '2023-02-11 13:56:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Featured_Articles', 'help', 'de', 'menu-items', 'menu-item-featured-articles.md', 'Menüeintrag: Hauptbeiträge', '2023-02-11 13:56:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Featured_Contacts', 'help', 'de', 'menu-items', 'menu-item-featured-contacts.md', 'Menüeintrag: Hauptkontakte', '2023-02-11 13:56:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Heading', 'help', 'de', 'menu-items', 'menu-item-heading.md', 'Menü-Eintrag: Titel', '2023-02-11 13:56:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_All_Categories', 'help', 'de', 'menu-items', 'menu-item-list-all-categories.md', 'Menüeintrag: Alle Kategorien auflisten', '2023-02-11 13:56:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_Contacts_in_a_Category', 'help', 'de', 'menu-items', 'menu-item-list-contacts-in-a-category.md', 'Menüeintrag: Kontakte in einer Kategorie auflisten', '2023-02-11 13:56:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Logout', 'help', 'de', 'menu-items', 'menu-item-logout.md', 'Menüeintrag: Logout', '2023-02-11 13:56:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_New_Item', 'help', 'de', 'menu-items', 'menu-item-new-item.md', 'Menüs: Neuer Eintrag', '2023-02-11 13:56:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Password_Reset', 'help', 'de', 'menu-items', 'menu-item-password-reset.md', 'Menüeintrag: Passwort zurücksetzen', '2023-02-11 13:57:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Registration_Form', 'help', 'de', 'menu-items', 'menu-item-registration-form.md', 'Menüeintrag: Registrierungsformular', '2023-02-11 13:57:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Single_Article', 'help', 'de', 'menu-items', 'menu-item-single-article.md', 'Menüeintrag: Einzelner Beitrag', '2023-02-11 13:57:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Single_Contact', 'help', 'de', 'menu-items', 'menu-item-single-contact.md', 'Menüeintrag: einzelner Kontakt', '2023-02-11 13:57:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_User_Profile', 'help', 'de', 'menu-items', 'menu-item-user-profile.md', 'Menüeintrag: Benutzerprofil', '2023-02-11 13:57:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Username_Reminder_Request', 'help', 'de', 'menu-items', 'menu-item-username-reminder-request.md', 'Menüeintrag: Benutzername erneut zusenden', '2023-02-11 13:57:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus', 'help', 'de', 'menus', 'menus.md', 'Menüs', '2023-02-11 13:57:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Edit', 'help', 'de', 'menus', 'menus-edit.md', 'Menüs: Bearbeiten', '2023-02-11 13:57:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Items', 'help', 'de', 'menus', 'menus-items.md', 'Menüs: Einträge', '2023-02-11 13:57:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Options', 'help', 'de', 'menus', 'menus-options.md', 'Menüs: Optionen', '2023-02-11 13:57:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Modules', 'help', 'de', 'modules', 'modules.md', 'Module', '2023-02-11 13:57:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations', 'help', 'de', 'multilingual-associations', 'multilingual-associations.md', 'Sprachverknüpfungen', '2023-02-11 13:57:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Edit', 'help', 'de', 'multilingual-associations', 'multilingual-associations-edit.md', 'Sprachverknüpfungen: Bearbeiten', '2023-02-11 13:57:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Options', 'help', 'de', 'multilingual-associations', 'multilingual-associations-options.md', 'Sprachverknüpfungen: Optionen', '2023-02-11 13:57:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:My_Profile', 'help', 'de', 'my-profile', 'my-profile.md', 'Mein Profil', '2023-02-11 13:57:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Permissions_for_Group', 'help', 'de', 'permissions', 'permissions-for-group.md', 'Berechtigungen für Gruppen', '2023-02-11 13:57:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Permissions_for_User', 'help', 'de', 'permissions', 'permissions-for-user.md', 'Berechtigungen für Benutzer', '2023-02-11 13:57:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Plugin:_Options', 'help', 'de', 'plugins', 'plugin-options.md', 'Plugin: Optionen', '2023-02-11 13:57:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Plugins', 'help', 'de', 'plugins', 'plugins.md', 'Plugins', '2023-02-11 13:57:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Plugins:_Name_of_Plugin', 'help', 'de', 'plugins', 'plugins-name-of-plugin.md', 'Plugins: Name des Plugins', '2023-02-11 13:58:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration', 'help', 'de', 'site', 'site-global-configuration.md', 'Konfiguration', '2023-02-11 13:58:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Logging', 'help', 'de', 'site', 'site-global-configuration-logging.md', 'Konfiguration: Protokollierung', '2023-02-11 13:58:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Permissions', 'help', 'de', 'site', 'site-global-configuration-permissions.md', 'Konfiguration: Berechtigungen', '2023-02-11 13:58:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Server', 'help', 'de', 'site', 'site-global-configuration-server.md', 'Konfiguration: Server', '2023-02-11 13:58:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Site', 'help', 'de', 'site', 'site-global-configuration-site.md', 'Konfiguration: Site', '2023-02-11 13:58:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_System', 'help', 'de', 'site', 'site-global-configuration-system.md', 'Konfiguration: System', '2023-02-11 13:58:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Text_Filters', 'help', 'de', 'site', 'site-global-configuration-text-filters.md', 'Konfiguration: Textfilter', '2023-02-11 13:58:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Archived', 'help', 'de', 'site-modules', 'site-modules-articles-archived.md', 'Site Modul: Beiträge – Archiv', '2023-02-11 13:58:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Categories', 'help', 'de', 'site-modules', 'site-modules-articles-categories.md', 'Site-Modul: Beiträge – Kategorien', '2023-02-11 13:58:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Category', 'help', 'de', 'site-modules', 'site-modules-articles-category.md', 'Site-Modul: Beiträge – Kategorie', '2023-02-11 13:58:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Latest', 'help', 'de', 'site-modules', 'site-modules-articles-latest.md', 'Site-Modul: Beiträge – Neueste', '2023-02-11 13:58:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Most_Read', 'help', 'de', 'site-modules', 'site-modules-articles-most-read.md', 'Site-Modul: Beiträge – Beliebte', '2023-02-11 13:58:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Newsflash', 'help', 'de', 'site-modules', 'site-modules-articles-newsflash.md', 'Site-Modul: Beiträge – Newsflash', '2023-02-11 13:58:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Related', 'help', 'de', 'site-modules', 'site-modules-articles-related.md', 'Site Modul: Beiträge – Verwandte', '2023-02-11 13:58:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Banners', 'help', 'de', 'site-modules', 'site-modules-banners.md', 'Site Modul: Banner', '2023-02-11 13:58:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Breadcrumbs', 'help', 'de', 'site-modules', 'site-modules-breadcrumbs.md', 'Site Modul: Navigationspfad (Breadcrumbs)', '2023-02-11 13:58:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Custom', 'help', 'de', 'site-modules', 'site-modules-custom.md', 'Site Modul: Eigenes Modul', '2023-02-11 13:58:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Feed_Display', 'help', 'de', 'site-modules', 'site-modules-feed-display.md', 'Site Modul: Externen Feed anzeigen', '2023-02-11 13:59:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Footer', 'help', 'de', 'site-modules', 'site-modules-footer.md', 'Site Modul: Fußzeile', '2023-02-11 13:59:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Language_Switcher', 'help', 'de', 'site-modules', 'site-modules-language-switcher.md', 'Site Modul: Sprachauswahl', '2023-02-11 13:59:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Latest_Users', 'help', 'de', 'site-modules', 'site-modules-latest-users.md', 'Site Modul: Benutzer – Neueste', '2023-02-11 13:59:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Login', 'help', 'de', 'site-modules', 'site-modules-login.md', 'Site Modul: Benutzer – Anmeldung', '2023-02-11 13:59:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Menu', 'help', 'de', 'site-modules', 'site-modules-menu.md', 'Site Modul: Menü', '2023-02-11 13:59:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Random_Image', 'help', 'de', 'site-modules', 'site-modules-random-image.md', 'Site Modul: Zufallsbild', '2023-02-11 13:59:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Smart_Search', 'help', 'de', 'site-modules', 'site-modules-smart-search.md', 'Site-Module: Suchindex', '2023-02-11 13:59:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Statistics', 'help', 'de', 'site-modules', 'site-modules-statistics.md', 'Site Module: Statistiken', '2023-02-11 13:59:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Syndication_Feeds', 'help', 'de', 'site-modules', 'site-modules-syndication-feeds.md', 'Site-Modul: Feeds – Feed erzeugen', '2023-02-11 13:59:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Tags_-_Popular', 'help', 'de', 'site-modules', 'site-modules-tags-popular.md', 'Site-Modul: Schlagwörter – Beliebte', '2023-02-11 13:59:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Tags_-_Similar', 'help', 'de', 'site-modules', 'site-modules-tags-similar.md', 'Site-Modul: Schlagwörter – Ähnliche', '2023-02-11 13:59:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Content_Maps', 'help', 'de', 'smart-search', 'smart-search-content-maps.md', 'Smart Search: Content Maps', '2023-02-11 13:59:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Options', 'help', 'de', 'smart-search', 'smart-search-options.md', 'Suchindex: Optionen', '2023-02-11 13:59:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Search_Term_Analysis', 'help', 'de', 'smart-search', 'smart-search-search-term-analysis.md', 'Suchindex: Suchbegriff-Analyse', '2023-02-11 13:59:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Tags', 'help', 'de', 'tags', 'tags.md', 'Schlagwörter', '2023-02-11 13:59:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Tags:_New_or_Edit', 'help', 'de', 'tags', 'tags-new-or-edit.md', 'Schlagwörter: Neu oder Bearbeiten', '2023-02-11 13:59:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Customise', 'help', 'de', 'templates', 'templates-customise.md', 'Templates: Anpassen', '2023-02-11 13:59:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Customise_Source', 'help', 'de', 'templates', 'templates-customise-source.md', 'Templates: Quellcode anpassen', '2023-02-11 13:59:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Edit_Style', 'help', 'de', 'templates', 'templates-edit-style.md', 'Templates: Stile bearbeiten', '2023-02-11 13:59:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Styles', 'help', 'de', 'templates', 'templates-styles.md', 'Templates: Stile', '2023-02-11 13:59:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Templates', 'help', 'de', 'templates', 'templates-templates.md', 'Templates: Templates', '2023-02-11 13:59:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Workflows_List', 'help', 'de', 'workflow', 'workflows-list.md', 'Workflows-Liste', '2023-02-11 13:59:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Edit_Update_Site', 'help', 'de', 'update-sites', 'edit-update-site.md', 'Update-Site bearbeiten', '2023-02-11 14:00:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Update_Sites', 'help', 'de', 'update-sites', 'extensions-update-sites.md', 'Erweiterungen: Update-Sites', '2023-02-11 14:00:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes', 'help', 'de', 'users', 'user-notes.md', 'Benutzerhinweise', '2023-02-11 14:00:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes:_Categories', 'help', 'de', 'users', 'user-notes-categories.md', 'Benutzerhinweise: Kategorien', '2023-02-11 14:00:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes:_New_or_Edit', 'help', 'de', 'users', 'user-notes-new-or-edit.md', 'Benutzerhinweise: Bearbeiten', '2023-02-11 14:00:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes:_New_or_Edit_Category', 'help', 'de', 'users', 'user-notes-new-or-edit-category.md', 'Benutzerhinweise: Kategorie neu erstellen oder bearbeiten', '2023-02-11 14:00:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users', 'help', 'de', 'users', 'users.md', 'Benutzer', '2023-02-11 14:00:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Edit_Profile', 'help', 'de', 'users', 'users-edit-profile.md', 'Benutzer: Profil bearbeiten', '2023-02-11 14:00:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Edit_Viewing_Access_Level', 'help', 'de', 'users', 'users-edit-viewing-access-level.md', 'Benutzer: Zugriffsebenen anzeigen und bearbeiten', '2023-02-11 14:00:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Groups', 'help', 'de', 'users', 'users-groups.md', 'Benutzer: Gruppen', '2023-02-11 14:00:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_New_or_Edit_Group', 'help', 'de', 'users', 'users-new-or-edit-group.md', 'Benutzer: Gruppe neu erstellen oder bearbeiten', '2023-02-11 14:00:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Options', 'help', 'de', 'users', 'users-options.md', 'Benutzer: Optionen', '2023-02-11 14:00:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Viewing_Access_Levels', 'help', 'de', 'users', 'users-viewing-access-levels.md', 'Benutzer: Zugriffsebenen anzeigen', '2023-02-11 14:00:31') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles', 'help', 'es', 'articles', 'articles.md', 'Artículos', '2023-02-11 14:01:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Categories', 'help', 'es', 'articles', 'articles-categories.md', 'Artículos: Categorías', '2023-02-11 14:01:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Edit', 'help', 'es', 'articles', 'articles-edit.md', 'Artículos: Editar', '2023-02-11 14:01:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Featured', 'help', 'es', 'articles', 'articles-featured.md', 'Artículos: Destacados', '2023-02-11 14:01:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Options', 'help', 'es', 'articles', 'articles-options.md', 'Artículos: Opciones', '2023-02-11 14:01:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Version_History', 'help', 'es', 'components', 'components-version-history.md', 'Historial de Versiones', '2023-02-11 14:01:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts', 'help', 'es', 'contacts', 'contacts.md', 'Contactos', '2023-02-11 14:01:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Editors', 'help', 'es', 'editors', 'editors.md', 'Editor', '2023-02-11 14:01:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Install', 'help', 'es', 'extensions', 'extensions-install.md', 'Extensiones: Instalar', '2023-02-11 14:02:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Languages', 'help', 'es', 'extensions', 'extensions-languages.md', 'Extensions: Languages', '2023-02-11 14:02:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Fields:_Edit', 'help', 'es', 'fields', 'fields-edit.md', 'Campos: Editar', '2023-02-11 14:02:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_Additional_Information', 'help', 'es', 'install-or-update', 'joomla-version-additional-information.md', 'Ayuda4.x: Información Adicional Sobre la Versión de Joomla', '2023-02-11 14:02:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Installed', 'help', 'es', 'languages', 'languages-installed.md', 'Idiomas: Instalados', '2023-02-11 14:02:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Maintenance:_Clear_Cache', 'help', 'es', 'mail', 'maintenance-clear-cache.md', 'Mantenimiento: Limpiar la caché', '2023-02-11 14:02:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Maintenance:_Global_Check-in', 'help', 'es', 'mail', 'maintenance-global-check-in.md', 'Mantenimiento: Desbloqueo global', '2023-02-11 14:02:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media', 'help', 'es', 'media', 'media.md', 'Multimedia', '2023-02-11 14:02:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media:_Options', 'help', 'es', 'media', 'media-options.md', 'Multimedia: Opciones', '2023-02-11 14:02:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Article_Archived', 'help', 'es', 'menu-items', 'menu-item-article-archived.md', 'Menús: Mostrar los artículos archivados', '2023-02-11 14:02:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Category_Blog', 'help', 'es', 'menu-items', 'menu-item-category-blog.md', 'Menús: Mostrar una categoría en formato blog', '2023-02-11 14:02:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Category_List', 'help', 'es', 'menu-items', 'menu-item-category-list.md', 'Menús: Mostrar una categoría en formato lista', '2023-02-11 14:02:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Create_Article', 'help', 'es', 'menu-items', 'menu-item-create-article.md', 'Menús: Mostrar el formulario para crear y enviar un artículo', '2023-02-11 14:03:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Featured_Articles', 'help', 'es', 'menu-items', 'menu-item-featured-articles.md', 'Menús: Mostrar todos los artículos destacados', '2023-02-11 14:03:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_All_Categories', 'help', 'es', 'menu-items', 'menu-item-list-all-categories.md', 'Menús: Mostrar listado de todas las categorías', '2023-02-11 14:03:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_New_Item', 'help', 'es', 'menu-items', 'menu-item-new-item.md', 'Menús: Nuevo elemento', '2023-02-11 14:03:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Single_Article', 'help', 'es', 'menu-items', 'menu-item-single-article.md', 'Menús: Mostrar un solo artículo', '2023-02-11 14:03:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus', 'help', 'es', 'menus', 'menus.md', 'Menús', '2023-02-11 14:03:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Items', 'help', 'es', 'menus', 'menus-items.md', 'Menús: Elementos', '2023-02-11 14:03:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Options', 'help', 'es', 'menus', 'menus-options.md', 'Menus: Options', '2023-02-11 14:03:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Modules', 'help', 'es', 'modules', 'modules.md', 'Módulos', '2023-02-11 14:03:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations', 'help', 'es', 'multilingual-associations', 'multilingual-associations.md', 'Asociaciones multiidioma', '2023-02-11 14:03:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Edit', 'help', 'es', 'multilingual-associations', 'multilingual-associations-edit.md', 'Asociaciones multiidioma: Editar', '2023-02-11 14:03:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Options', 'help', 'es', 'multilingual-associations', 'multilingual-associations-options.md', 'Asociaciones multiidioma: Opciones', '2023-02-11 14:03:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Plugins', 'help', 'es', 'plugins', 'plugins.md', 'Plugins', '2023-02-11 14:04:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration', 'help', 'es', 'site', 'site-global-configuration.md', 'Configuración global', '2023-02-11 14:04:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Logging', 'help', 'es', 'site', 'site-global-configuration-logging.md', 'Configuración global: Registro', '2023-02-11 14:04:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Permissions', 'help', 'es', 'site', 'site-global-configuration-permissions.md', 'Configuración global: Permisos', '2023-02-11 14:04:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Server', 'help', 'es', 'site', 'site-global-configuration-server.md', 'Configuración global: Servidor', '2023-02-11 14:04:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Site', 'help', 'es', 'site', 'site-global-configuration-site.md', 'Configuración global: Sitio', '2023-02-11 14:04:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_System', 'help', 'es', 'site', 'site-global-configuration-system.md', 'Configuración global: Sistema', '2023-02-11 14:04:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Text_Filters', 'help', 'es', 'site', 'site-global-configuration-text-filters.md', 'Configuración global: Filtros de texto', '2023-02-11 14:04:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Banners', 'help', 'es', 'site-modules', 'site-modules-banners.md', 'Site Modules: Banners', '2023-02-11 14:04:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Breadcrumbs', 'help', 'es', 'site-modules', 'site-modules-breadcrumbs.md', 'Site Modules: Breadcrumbs', '2023-02-11 14:04:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Menu', 'help', 'es', 'site-modules', 'site-modules-menu.md', 'Site Modules: Menu', '2023-02-11 14:04:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Tags', 'help', 'es', 'tags', 'tags.md', 'Tags', '2023-02-11 14:05:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Customise', 'help', 'es', 'templates', 'templates-customise.md', 'Plantillas: Personalizar', '2023-02-11 14:05:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Styles', 'help', 'es', 'templates', 'templates-styles.md', 'Plantillas: Estilos', '2023-02-11 14:05:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users', 'help', 'es', 'users', 'users.md', 'Usuarios', '2023-02-11 14:05:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Options', 'help', 'es', 'users', 'users-options.md', 'Usuarios: Opciones', '2023-02-11 14:05:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Viewing_Access_Levels', 'help', 'es', 'users', 'users-viewing-access-levels.md', 'Usuarios: Visualización de niveles de acceso', '2023-02-11 14:05:42') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Start_Here', 'help', 'fr', 'help-screens', 'start-here.md', 'Par où commencer ?', '2023-02-11 14:06:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles', 'help', 'fr', 'articles', 'articles.md', 'Articles', '2023-02-11 14:06:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Categories', 'help', 'fr', 'articles', 'articles-categories.md', 'Articles : catégories', '2023-02-11 14:06:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Edit', 'help', 'fr', 'articles', 'articles-edit.md', 'Articles : Edition', '2023-02-11 14:06:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Featured', 'help', 'fr', 'articles', 'articles-featured.md', 'Articles : Articles épinglés', '2023-02-11 14:06:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Options', 'help', 'fr', 'articles', 'articles-options.md', 'Articles : Paramètres', '2023-02-11 14:06:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners', 'help', 'fr', 'banners', 'banners.md', 'Bannières', '2023-02-11 14:06:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Version_History', 'help', 'fr', 'components', 'components-version-history.md', 'Composants Historique de versions', '2023-02-11 14:07:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts', 'help', 'fr', 'contacts', 'contacts.md', 'Contact', '2023-02-11 14:07:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Editors', 'help', 'fr', 'editors', 'editors.md', 'Éditeur', '2023-02-11 14:07:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Install', 'help', 'fr', 'extensions', 'extensions-install.md', 'Extensions : Installer', '2023-02-11 14:07:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Languages', 'help', 'fr', 'extensions', 'extensions-languages.md', 'Extensions: Languages', '2023-02-11 14:07:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Update', 'help', 'fr', 'extensions', 'extensions-update.md', 'Extensions : Mettre à jour', '2023-02-11 14:07:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Fields:_Edit', 'help', 'fr', 'fields', 'fields-edit.md', 'Champs : Edition', '2023-02-11 14:07:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Glossary', 'help', 'fr', 'glossary', 'glossary.md', 'Glossaire', '2023-02-11 14:07:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Information:_Database', 'help', 'fr', 'information', 'information-database.md', 'Information : Base de données', '2023-02-11 14:07:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Information:_Warnings', 'help', 'fr', 'information', 'information-warnings.md', 'Information : Avertissements', '2023-02-11 14:07:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Update', 'help', 'fr', 'install-or-update', 'joomla-update.md', 'Mise à jour de Joomla', '2023-02-11 14:07:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_4_0_1', 'help', 'fr', 'install-or-update', 'joomla-version-4-0-1.md', 'Joomla! Version 4.0.1', '2023-02-11 14:08:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_Information', 'help', 'fr', 'install-or-update', 'joomla-version-information.md', 'Informations de version Joomla!', '2023-02-11 14:08:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Installed', 'help', 'fr', 'languages', 'languages-installed.md', 'Langues : Installées', '2023-02-11 14:08:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Maintenance:_Clear_Cache', 'help', 'fr', 'mail', 'maintenance-clear-cache.md', 'Maintenance: Clear Cache', '2023-02-11 14:08:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Maintenance:_Global_Check-in', 'help', 'fr', 'mail', 'maintenance-global-check-in.md', 'Maintenance : Déverrouillage global', '2023-02-11 14:08:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media', 'help', 'fr', 'media', 'media.md', 'Médias', '2023-02-11 14:08:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media:_Options', 'help', 'fr', 'media', 'media-options.md', 'Médias : Paramètres', '2023-02-11 14:08:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Article_Archived', 'help', 'fr', 'menu-items', 'menu-item-article-archived.md', 'Menus : Articles archivés', '2023-02-11 14:08:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Category_Blog', 'help', 'fr', 'menu-items', 'menu-item-category-blog.md', 'Menus : Blog d''une catégorie', '2023-02-11 14:08:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Category_List', 'help', 'fr', 'menu-items', 'menu-item-category-list.md', 'Menus : Liste d''articles d''une catégorie', '2023-02-11 14:08:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Create_Article', 'help', 'fr', 'menu-items', 'menu-item-create-article.md', 'Menus : Créer un article', '2023-02-11 14:08:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Edit_User_Profile', 'help', 'fr', 'menu-items', 'menu-item-edit-user-profile.md', 'Élément de menu : Modifier le profil de l''utilisateur', '2023-02-11 14:08:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Featured_Articles', 'help', 'fr', 'menu-items', 'menu-item-featured-articles.md', 'Menus : Articles épinglés', '2023-02-11 14:08:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_All_Categories', 'help', 'fr', 'menu-items', 'menu-item-list-all-categories.md', 'Menus : Liste des catégories d''une catégorie parente', '2023-02-11 14:08:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_New_Item', 'help', 'fr', 'menu-items', 'menu-item-new-item.md', 'Menus : Ajouter un lien de menu', '2023-02-11 14:08:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Single_Article', 'help', 'fr', 'menu-items', 'menu-item-single-article.md', 'Menus : Article', '2023-02-11 14:09:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus', 'help', 'fr', 'menus', 'menus.md', 'Menus', '2023-02-11 14:09:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Items', 'help', 'fr', 'menus', 'menus-items.md', 'Menus: Items', '2023-02-11 14:09:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Options', 'help', 'fr', 'menus', 'menus-options.md', 'Menus: Options', '2023-02-11 14:09:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Modules', 'help', 'fr', 'modules', 'modules.md', 'Modules', '2023-02-11 14:09:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations', 'help', 'fr', 'multilingual-associations', 'multilingual-associations.md', 'Associations multilingues', '2023-02-11 14:09:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Edit', 'help', 'fr', 'multilingual-associations', 'multilingual-associations-edit.md', 'Associations multilingues : Edition', '2023-02-11 14:09:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Options', 'help', 'fr', 'multilingual-associations', 'multilingual-associations-options.md', 'Associations multilingues : Paramètres', '2023-02-11 14:09:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Plugins', 'help', 'fr', 'plugins', 'plugins.md', 'Plugins', '2023-02-11 14:09:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Post-installation_Messages_for_Joomla_CMS', 'help', 'fr', 'post-install-messages', 'post-installation-messages-for-joomla-cms.md', 'Messages post-installation pour le CMS Joomla', '2023-02-11 14:09:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_New_Information_Request', 'help', 'fr', 'privacy', 'privacy-new-information-request.md', 'Confidentialité : Nouvelle demande d''information', '2023-02-11 14:09:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration', 'help', 'fr', 'site', 'site-global-configuration.md', 'Configuration globale', '2023-02-11 14:10:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Logging', 'help', 'fr', 'site', 'site-global-configuration-logging.md', 'Configuration globale : Journal (log)', '2023-02-11 14:10:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Permissions', 'help', 'fr', 'site', 'site-global-configuration-permissions.md', 'Configuration globale : Droits', '2023-02-11 14:10:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Server', 'help', 'fr', 'site', 'site-global-configuration-server.md', 'Configuration globale : Serveur', '2023-02-11 14:10:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Site', 'help', 'fr', 'site', 'site-global-configuration-site.md', 'Configuration globale : Site', '2023-02-11 14:10:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_System', 'help', 'fr', 'site', 'site-global-configuration-system.md', 'Configuration globale : Système', '2023-02-11 14:10:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Text_Filters', 'help', 'fr', 'site', 'site-global-configuration-text-filters.md', 'Configuration globale : Filtres de texte', '2023-02-11 14:10:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Banners', 'help', 'fr', 'site-modules', 'site-modules-banners.md', 'Site Modules: Banners', '2023-02-11 14:10:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Breadcrumbs', 'help', 'fr', 'site-modules', 'site-modules-breadcrumbs.md', 'Site Modules: Breadcrumbs', '2023-02-11 14:10:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Menu', 'help', 'fr', 'site-modules', 'site-modules-menu.md', 'Site Modules: Menu', '2023-02-11 14:10:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Tags', 'help', 'fr', 'tags', 'tags.md', 'Tags', '2023-02-11 14:10:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Customise', 'help', 'fr', 'templates', 'templates-customise.md', 'Templates : Personnaliser', '2023-02-11 14:11:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Styles', 'help', 'fr', 'templates', 'templates-styles.md', 'Templates : Styles', '2023-02-11 14:11:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes', 'help', 'fr', 'users', 'user-notes.md', 'Notes utilisateurs', '2023-02-11 14:11:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users', 'help', 'fr', 'users', 'users.md', 'Utilisateurs', '2023-02-11 14:11:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Groups', 'help', 'fr', 'users', 'users-groups.md', 'Utilisateurs : Groupes', '2023-02-11 14:11:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Options', 'help', 'fr', 'users', 'users-options.md', 'Utilisateurs : Paramètres', '2023-02-11 14:11:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Viewing_Access_Levels', 'help', 'fr', 'users', 'users-viewing-access-levels.md', 'Utilisateurs : Niveaux d''accès', '2023-02-11 14:11:28') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Start_Here', 'help', 'nl', 'help-screens', 'start-here.md', 'Begin hier', '2023-02-11 14:12:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Action_Logs_-_Latest', 'help', 'nl', 'admin-modules', 'admin-modules-action-logs-latest.md', 'Beheer modules: Actielog - Nieuwste', '2023-02-11 14:12:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Administrator_Dashboard_Menu', 'help', 'nl', 'admin-modules', 'admin-modules-administrator-dashboard-menu.md', 'Beheerder modules: Beheerder dashboard menu', '2023-02-11 14:12:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Administrator_Menu', 'help', 'nl', 'admin-modules', 'admin-modules-administrator-menu.md', 'Beheerder modules: Beheerder menu', '2023-02-11 14:12:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Articles_-_Latest', 'help', 'nl', 'admin-modules', 'admin-modules-articles-latest.md', 'Modules: Nieuwste artikelen', '2023-02-11 14:12:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Custom', 'help', 'nl', 'admin-modules', 'admin-modules-custom.md', 'Beheerder modules: Aangepast', '2023-02-11 14:12:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Feed_Display', 'help', 'nl', 'admin-modules', 'admin-modules-feed-display.md', 'Beheerder modules: Nieuwsfeed tonen', '2023-02-11 14:12:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Frontend_Link', 'help', 'nl', 'admin-modules', 'admin-modules-frontend-link.md', 'Beheer modules: Link naar de website', '2023-02-11 14:12:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Joomla_Version_Information', 'help', 'nl', 'admin-modules', 'admin-modules-joomla-version-information.md', 'Beheerder modules: Joomla versie informatie', '2023-02-11 14:12:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Logged-in_Users', 'help', 'nl', 'admin-modules', 'admin-modules-logged-in-users.md', 'Beheer modules: Ingelogde gebruikers', '2023-02-11 14:12:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Login_Form', 'help', 'nl', 'admin-modules', 'admin-modules-login-form.md', 'Beheerder modules: Inlogformulier', '2023-02-11 14:12:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Login_Support_Information', 'help', 'nl', 'admin-modules', 'admin-modules-login-support-information.md', 'Beheerder modules: Inlog ondersteuningsinformatie', '2023-02-11 14:12:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Messages', 'help', 'nl', 'admin-modules', 'admin-modules-messages.md', 'Beheerder modules: Berichten', '2023-02-11 14:12:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Multilingual_Status', 'help', 'nl', 'admin-modules', 'admin-modules-multilingual-status.md', 'Beheerder modules: Meertalige status', '2023-02-11 14:12:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Popular_Articles', 'help', 'nl', 'admin-modules', 'admin-modules-popular-articles.md', 'Beheerder modules: Populaire artikelen', '2023-02-11 14:12:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Post_Installation_Messages', 'help', 'nl', 'admin-modules', 'admin-modules-post-installation-messages.md', 'Beheerder modules: Post-installatie berichten', '2023-02-11 14:12:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Privacy_Dashboard', 'help', 'nl', 'admin-modules', 'admin-modules-privacy-dashboard.md', 'Beheerder modules: Privacy dashboard', '2023-02-11 14:12:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Privacy_Status_Check', 'help', 'nl', 'admin-modules', 'admin-modules-privacy-status-check.md', 'Beheerder modules: Privacystatus controle', '2023-02-11 14:12:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Quick_Icons', 'help', 'nl', 'admin-modules', 'admin-modules-quick-icons.md', 'Beheerder modules: Snelkoppelingen', '2023-02-11 14:12:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Sample_Data', 'help', 'nl', 'admin-modules', 'admin-modules-sample-data.md', 'Beheerder modules: Voorbeelddata', '2023-02-11 14:12:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Title', 'help', 'nl', 'admin-modules', 'admin-modules-title.md', 'Beheerder modules: Titel', '2023-02-11 14:12:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Toolbar', 'help', 'nl', 'admin-modules', 'admin-modules-toolbar.md', 'Beheerder modules: Werkbalk', '2023-02-11 14:12:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_User_Menu', 'help', 'nl', 'admin-modules', 'admin-modules-user-menu.md', 'Beheerder modules: Gebruikersmenu', '2023-02-11 14:12:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles', 'help', 'nl', 'articles', 'articles.md', 'Artikelen', '2023-02-11 14:12:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Categories', 'help', 'nl', 'articles', 'articles-categories.md', 'Artikelen: Categorieën', '2023-02-11 14:12:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Edit', 'help', 'nl', 'articles', 'articles-edit.md', 'Artikelen: Bewerken', '2023-02-11 14:13:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Featured', 'help', 'nl', 'articles', 'articles-featured.md', 'Artikelen: Speciale artikelen', '2023-02-11 14:13:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Options', 'help', 'nl', 'articles', 'articles-options.md', 'Artikelen: Opties', '2023-02-11 14:13:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners', 'help', 'nl', 'banners', 'banners.md', 'Advertenties', '2023-02-11 14:13:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Categories', 'help', 'nl', 'banners', 'banners-categories.md', 'Advertenties: Categorieën', '2023-02-11 14:13:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Clients', 'help', 'nl', 'banners', 'banners-clients.md', 'Advertenties: Adverteerders', '2023-02-11 14:13:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Edit', 'help', 'nl', 'banners', 'banners-edit.md', 'Advertenties: Bewerken', '2023-02-11 14:13:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_New_or_Edit_Category', 'help', 'nl', 'banners', 'banners-new-or-edit-category.md', 'Advertenties: Nieuwe of bewerken van categorieën', '2023-02-11 14:13:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_New_or_Edit_Client', 'help', 'nl', 'banners', 'banners-new-or-edit-client.md', 'Advertenties: Nieuwe of bewerken van adverteerder', '2023-02-11 14:13:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Options', 'help', 'nl', 'banners', 'banners-options.md', 'Advertenties: Opties', '2023-02-11 14:13:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Tracks', 'help', 'nl', 'banners', 'banners-tracks.md', 'Advertenties: Volgen', '2023-02-11 14:13:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Cache:_Options', 'help', 'nl', 'cache', 'cache-options.md', 'Cache: Opties', '2023-02-11 14:13:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Check-in:_Options', 'help', 'nl', 'cache', 'check-in-options.md', 'Inchecken: Opties', '2023-02-11 14:13:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Banners_Banners_Edit', 'help', 'nl', 'components', 'components-banners-banners-edit.md', 'Components Banners Banners Edit', '2023-02-11 14:13:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Check-in_Configuration', 'help', 'nl', 'components', 'components-check-in-configuration.md', 'Componenten -  Check-in - Instellingen', '2023-02-11 14:13:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Patch_Tester_Options', 'help', 'nl', 'components', 'components-patch-tester-options.md', 'Componenten - Patchtester - Opties', '2023-02-11 14:13:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Plug-in_Manager_Options', 'help', 'nl', 'components', 'components-plug-in-manager-options.md', 'Componenten - Pluginbeheer - Opties', '2023-02-11 14:13:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Privacy_Outline', 'help', 'nl', 'components', 'components-privacy-outline.md', 'Componenten - Privacy overzicht', '2023-02-11 14:13:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Redirect_Manager', 'help', 'nl', 'components', 'components-redirect-manager.md', 'Verwijzingen: Links', '2023-02-11 14:13:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Version_History', 'help', 'nl', 'components', 'components-version-history.md', 'Componenten Versiegeschiedenis', '2023-02-11 14:13:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts', 'help', 'nl', 'contacts', 'contacts.md', 'Contactpersonen', '2023-02-11 14:13:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts:_Categories', 'help', 'nl', 'contacts', 'contacts-categories.md', 'Contactpersonen: Categorieën', '2023-02-11 14:14:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Contacts:_Options', 'help', 'nl', 'contacts', 'contacts-options.md', 'Contactpersonen: Opties', '2023-02-11 14:14:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Editors', 'help', 'nl', 'editors', 'editors.md', 'Tekstverwerkers', '2023-02-11 14:14:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:TinyMCE', 'help', 'nl', 'editors', 'tinymce.md', 'TinyMCE', '2023-02-11 14:14:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Discover', 'help', 'nl', 'extensions', 'extensions-discover.md', 'Extensies: Ontdekken', '2023-02-11 14:14:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Install', 'help', 'nl', 'extensions', 'extensions-install.md', 'Extensies: Installeren', '2023-02-11 14:14:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Languages', 'help', 'nl', 'extensions', 'extensions-languages.md', 'Extensies: Talen', '2023-02-11 14:14:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Manage', 'help', 'nl', 'extensions', 'extensions-manage.md', 'Extensies: Beheren', '2023-02-11 14:14:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Update', 'help', 'nl', 'extensions', 'extensions-update.md', 'Extensies: Update', '2023-02-11 14:14:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Extension_Manager_Languages', 'help', 'nl', 'extensions', 'extensions-extension-manager-languages.md', 'Extensies - Extensiebeheer - Beheer talen', '2023-02-11 14:14:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Module_Manager_Articles_Categories', 'help', 'nl', 'extensions', 'extensions-module-manager-articles-categories.md', 'Site modules: Artikelen - Categorieën', '2023-02-11 14:14:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Module_Manager_Edit', 'help', 'nl', 'extensions', 'extensions-module-manager-edit.md', 'Extensies - Modulebeheer - Bewerken', '2023-02-11 14:14:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Module_Manager_Sample_Data', 'help', 'nl', 'extensions', 'extensions-module-manager-sample-data.md', 'Extensies - Modulebeheer - Voorbeelddata', '2023-02-11 14:14:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions_Modules_Administrator', 'help', 'nl', 'extensions', 'extensions-modules-administrator.md', 'Extensies - Beheermodules', '2023-02-11 14:14:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Fields:_Edit', 'help', 'nl', 'fields', 'fields-edit.md', 'Velden: Bewerken', '2023-02-11 14:14:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Glossary', 'help', 'nl', 'glossary', 'glossary.md', 'Woordenlijst', '2023-02-11 14:14:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Information:_Database', 'help', 'nl', 'information', 'information-database.md', 'Informatie: Database', '2023-02-11 14:14:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Information:_Warnings', 'help', 'nl', 'information', 'information-warnings.md', 'Informatie: Waarschuwingen', '2023-02-11 14:14:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Installer:_Options', 'help', 'nl', 'install-or-update', 'installer-options.md', 'Installeren: Opties', '2023-02-11 14:14:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Update', 'help', 'nl', 'install-or-update', 'joomla-update.md', 'Joomla update', '2023-02-11 14:14:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Update:_Options', 'help', 'nl', 'install-or-update', 'joomla-update-options.md', 'Joomla update: Opties', '2023-02-11 14:14:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_4_0_0', 'help', 'nl', 'install-or-update', 'joomla-version-4-0-0.md', 'Joomla! versie 4.0.0', '2023-02-11 14:14:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_4_0_1', 'help', 'nl', 'install-or-update', 'joomla-version-4-0-1.md', 'Joomla! versie 4.0.1', '2023-02-11 14:14:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_4_0_2', 'help', 'nl', 'install-or-update', 'joomla-version-4-0-2.md', 'Joomla! versie 4.0.2', '2023-02-11 14:14:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_4_0_3', 'help', 'nl', 'install-or-update', 'joomla-version-4-0-3.md', 'Joomla! versie 4.0.3', '2023-02-11 14:14:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_4_0_4', 'help', 'nl', 'install-or-update', 'joomla-version-4-0-4.md', 'Joomla! versie 4.0.4', '2023-02-11 14:15:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_Additional_Information', 'help', 'nl', 'install-or-update', 'joomla-version-additional-information.md', 'Extra informatie over Joomla versies', '2023-02-11 14:15:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Joomla_Version_Information', 'help', 'nl', 'install-or-update', 'joomla-version-information.md', 'Joomla versie informatie', '2023-02-11 14:15:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Content', 'help', 'nl', 'languages', 'languages-content.md', 'Talen: Inhoud', '2023-02-11 14:15:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Edit_Content_Language', 'help', 'nl', 'languages', 'languages-edit-content-language.md', 'Talen - Inhoudstaal bewerken', '2023-02-11 14:15:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Edit_Override', 'help', 'nl', 'languages', 'languages-edit-override.md', 'Talen: Overrides bewerken', '2023-02-11 14:15:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Installed', 'help', 'nl', 'languages', 'languages-installed.md', 'Talen: Geïnstalleerd', '2023-02-11 14:15:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Options', 'help', 'nl', 'languages', 'languages-options.md', 'Talen: Opties', '2023-02-11 14:15:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Overrides', 'help', 'nl', 'languages', 'languages-overrides.md', 'Talen: Overrides', '2023-02-11 14:15:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Mail_Templates', 'help', 'nl', 'mail', 'mail-templates.md', 'E-mail templates', '2023-02-11 14:15:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Mail_Templates:_Options', 'help', 'nl', 'mail', 'mail-templates-options.md', 'E-mail templates: Opties', '2023-02-11 14:15:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Maintenance:_Clear_Cache', 'help', 'nl', 'mail', 'maintenance-clear-cache.md', 'Onderhoud: Wis cache', '2023-02-11 14:15:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Maintenance:_Global_Check-in', 'help', 'nl', 'mail', 'maintenance-global-check-in.md', 'Onderhoud: Algemene check-in', '2023-02-11 14:15:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Mass_Mail_Users', 'help', 'nl', 'mail', 'mass-mail-users.md', 'Groepsmail gebruikers', '2023-02-11 14:15:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media', 'help', 'nl', 'media', 'media.md', 'Media', '2023-02-11 14:15:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media:_Options', 'help', 'nl', 'media', 'media-options.md', 'Media: Opties', '2023-02-11 14:15:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Alias', 'help', 'nl', 'menu-items', 'menu-item-alias.md', 'Menu-item: Alias', '2023-02-11 14:15:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Article_Archived', 'help', 'nl', 'menu-items', 'menu-item-article-archived.md', 'Menu-item: Gearchiveerde artikelen', '2023-02-11 14:15:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Category_Blog', 'help', 'nl', 'menu-items', 'menu-item-category-blog.md', 'Menu-item: Categorieblog', '2023-02-11 14:15:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Category_List', 'help', 'nl', 'menu-items', 'menu-item-category-list.md', 'Menu-item: Categorielijst', '2023-02-11 14:15:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Compact_List_of_Tagged_Items', 'help', 'nl', 'menu-items', 'menu-item-compact-list-of-tagged-items.md', 'Menu-item: Compacte lijst met getagde items', '2023-02-11 14:15:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Confirm_Request', 'help', 'nl', 'menu-items', 'menu-item-confirm-request.md', 'Menu-item: Verzoek bevestigen', '2023-02-11 14:15:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Create_Article', 'help', 'nl', 'menu-items', 'menu-item-create-article.md', 'Menu-item: Aanmaken artikel', '2023-02-11 14:15:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Create_Contact', 'help', 'nl', 'menu-items', 'menu-item-create-contact.md', 'Menu-item: Aanmaken contactpersoon', '2023-02-11 14:15:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Create_Request', 'help', 'nl', 'menu-items', 'menu-item-create-request.md', 'Menu-item: Verzoek aanmaken', '2023-02-11 14:15:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Display_Template_Options', 'help', 'nl', 'menu-items', 'menu-item-display-template-options.md', 'Menu-item: Toon template opties', '2023-02-11 14:16:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Edit_User_Profile', 'help', 'nl', 'menu-items', 'menu-item-edit-user-profile.md', 'Menu-item: Bewerk gebruikersprofiel', '2023-02-11 14:16:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Extend_Consent', 'help', 'nl', 'menu-items', 'menu-item-extend-consent.md', 'Menu Item: Breid toestemming uit', '2023-02-11 14:16:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Featured_Articles', 'help', 'nl', 'menu-items', 'menu-item-featured-articles.md', 'Menu-item: Speciale artikelen', '2023-02-11 14:16:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Featured_Contacts', 'help', 'nl', 'menu-items', 'menu-item-featured-contacts.md', 'Menu-item: Speciale contactpersonen', '2023-02-11 14:16:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Heading', 'help', 'nl', 'menu-items', 'menu-item-heading.md', 'Menu-item: Menukop', '2023-02-11 14:16:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Iframe_Wrapper', 'help', 'nl', 'menu-items', 'menu-item-iframe-wrapper.md', 'Menu-item: Iframe wrapper', '2023-02-11 14:16:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_All_Categories', 'help', 'nl', 'menu-items', 'menu-item-list-all-categories.md', 'Menu-item: Lijst met alle categorieën', '2023-02-11 14:16:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_All_Contact_Categories', 'help', 'nl', 'menu-items', 'menu-item-list-all-contact-categories.md', 'Menu-item: Lijst met alle categorieën', '2023-02-11 14:16:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_All_News_Feed_Categories', 'help', 'nl', 'menu-items', 'menu-item-list-all-news-feed-categories.md', 'Menu-item: Lijst met alle nieuwsfeedcategorieën', '2023-02-11 14:16:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_All_Tags', 'help', 'nl', 'menu-items', 'menu-item-list-all-tags.md', 'Menu-item: Lijst met alle tags', '2023-02-11 14:16:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_Contacts_in_a_Category', 'help', 'nl', 'menu-items', 'menu-item-list-contacts-in-a-category.md', 'Meni-item: Lijst met contactpersonen in een categorie', '2023-02-11 14:16:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_News_Feeds_in_a_Category', 'help', 'nl', 'menu-items', 'menu-item-list-news-feeds-in-a-category.md', 'Menu-item: Lijst met nieuwsfeeds in een categorie', '2023-02-11 14:16:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Login_Form', 'help', 'nl', 'menu-items', 'menu-item-login-form.md', 'Menu-item: Inlogformulier', '2023-02-11 14:16:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Logout', 'help', 'nl', 'menu-items', 'menu-item-logout.md', 'Menu-item: Uitloggen', '2023-02-11 14:16:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_New_Item', 'help', 'nl', 'menu-items', 'menu-item-new-item.md', 'Menu''s: Nieuw item', '2023-02-11 14:16:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Password_Reset', 'help', 'nl', 'menu-items', 'menu-item-password-reset.md', 'Menu-item: Wachtwoord herinstellen', '2023-02-11 14:16:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Registration_Form', 'help', 'nl', 'menu-items', 'menu-item-registration-form.md', 'Menu-item: Registratieformulier', '2023-02-11 14:16:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Search', 'help', 'nl', 'menu-items', 'menu-item-search.md', 'Menu-item: Zoeken', '2023-02-11 14:16:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Separator', 'help', 'nl', 'menu-items', 'menu-item-separator.md', 'Menu-item: Scheidingsteken', '2023-02-11 14:16:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Single_Article', 'help', 'nl', 'menu-items', 'menu-item-single-article.md', 'Menu-item: Individueel artikel', '2023-02-11 14:16:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Single_Contact', 'help', 'nl', 'menu-items', 'menu-item-single-contact.md', 'Menu-item: Een enkele contactpersoon', '2023-02-11 14:16:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Single_News_Feed', 'help', 'nl', 'menu-items', 'menu-item-single-news-feed.md', 'Menu-item: Een enkel newsfeed', '2023-02-11 14:16:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Site_Configuration_Options', 'help', 'nl', 'menu-items', 'menu-item-site-configuration-options.md', 'Menu-Item: Website instellingen opties', '2023-02-11 14:16:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Tagged_Items', 'help', 'nl', 'menu-items', 'menu-item-tagged-items.md', 'Menu-item: Getagde items', '2023-02-11 14:16:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_URL', 'help', 'nl', 'menu-items', 'menu-item-url.md', 'Menu-item: URL', '2023-02-11 14:17:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_User_Profile', 'help', 'nl', 'menu-items', 'menu-item-user-profile.md', 'Menu-item: Gebruikersprofiel', '2023-02-11 14:17:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Username_Reminder_Request', 'help', 'nl', 'menu-items', 'menu-item-username-reminder-request.md', 'Menu-item: Herinneringsverzoek', '2023-02-11 14:17:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus', 'help', 'nl', 'menus', 'menus.md', 'Menu''s', '2023-02-11 14:17:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Edit', 'help', 'nl', 'menus', 'menus-edit.md', 'Menu''s: Bewerken', '2023-02-11 14:17:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Items', 'help', 'nl', 'menus', 'menus-items.md', 'Menu''s: Items', '2023-02-11 14:17:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Options', 'help', 'nl', 'menus', 'menus-options.md', 'Menu''s: Opties', '2023-02-11 14:17:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Messages:_Options', 'help', 'nl', 'messages', 'messages-options.md', 'Berichten: Opties', '2023-02-11 14:17:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Modules', 'help', 'nl', 'modules', 'modules.md', 'Modules', '2023-02-11 14:17:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations', 'help', 'nl', 'multilingual-associations', 'multilingual-associations.md', 'Meertaligheid associaties', '2023-02-11 14:17:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Edit', 'help', 'nl', 'multilingual-associations', 'multilingual-associations-edit.md', 'Meertaligheid associaties: Bewerken', '2023-02-11 14:17:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Options', 'help', 'nl', 'multilingual-associations', 'multilingual-associations-options.md', 'Meertaligheid associaties: Opties', '2023-02-11 14:17:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:My_Profile', 'help', 'nl', 'my-profile', 'my-profile.md', 'Mijn profiel', '2023-02-11 14:17:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:News_Feed:_Options', 'help', 'nl', 'news-feed', 'news-feed-options.md', 'Nieuwsfeeds: Opties', '2023-02-11 14:17:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:News_Feeds', 'help', 'nl', 'news-feed', 'news-feeds.md', 'Nieuwsfeeds', '2023-02-11 14:17:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:News_Feeds:_Categories', 'help', 'nl', 'news-feed', 'news-feeds-categories.md', 'Nieuwsfeeds: Categorieën', '2023-02-11 14:17:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Permissions_for_Group', 'help', 'nl', 'permissions', 'permissions-for-group.md', 'Rechten voor de groep', '2023-02-11 14:17:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Permissions_for_User', 'help', 'nl', 'permissions', 'permissions-for-user.md', 'Rechten voor gebruikers', '2023-02-11 14:17:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Plugin:_Options', 'help', 'nl', 'plugins', 'plugin-options.md', 'Plugin: Opties', '2023-02-11 14:17:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Plugins', 'help', 'nl', 'plugins', 'plugins.md', 'Plugins', '2023-02-11 14:17:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Plugins:_Name_of_Plugin', 'help', 'nl', 'plugins', 'plugins-name-of-plugin.md', 'Plugins: Bewerken van plugin', '2023-02-11 14:17:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Post-installation_Messages:_Options', 'help', 'nl', 'post-install-messages', 'post-installation-messages-options.md', 'Post-installatie berichten: Opties', '2023-02-11 14:17:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Post-installation_Messages_for_Joomla_CMS', 'help', 'nl', 'post-install-messages', 'post-installation-messages-for-joomla-cms.md', 'Post-installatie berichten voor het Joomla CMS', '2023-02-11 14:17:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_Consents', 'help', 'nl', 'privacy', 'privacy-consents.md', 'Privacy: Toestemmingen', '2023-02-11 14:17:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_Extension_Capabilities', 'help', 'nl', 'privacy', 'privacy-extension-capabilities.md', 'Privacy: Extensie mogelijkheden', '2023-02-11 14:18:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_Information_Requests', 'help', 'nl', 'privacy', 'privacy-information-requests.md', 'Privacy: Informatieverzoeken', '2023-02-11 14:18:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_New_Information_Request', 'help', 'nl', 'privacy', 'privacy-new-information-request.md', 'Privacy: Nieuw informatieverzoek', '2023-02-11 14:18:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_Options', 'help', 'nl', 'privacy', 'privacy-options.md', 'Privacy: Opties', '2023-02-11 14:18:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy:_Review_Information_Request', 'help', 'nl', 'privacy', 'privacy-review-information-request.md', 'Privacy: Beoordeel informatieverzoek', '2023-02-11 14:18:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Privacy_Dashboard', 'help', 'nl', 'privacy', 'privacy-dashboard.md', 'Privacy dashboard', '2023-02-11 14:18:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Private_Messages', 'help', 'nl', 'privacy', 'private-messages.md', 'Privéberichten', '2023-02-11 14:18:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Private_Messages:_Read', 'help', 'nl', 'private-messages', 'private-messages-read.md', 'Privéberichten: Bekijken', '2023-02-11 14:18:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Private_Messages:_Write', 'help', 'nl', 'private-messages', 'private-messages-write.md', 'Privéberichten: Opstellen', '2023-02-11 14:18:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Redirect:_Options', 'help', 'nl', 'redirect', 'redirect-options.md', 'Verwijzingen: Opties', '2023-02-11 14:18:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Redirects:_Links', 'help', 'nl', 'redirect', 'redirects-links.md', 'Verwijzingen: Links', '2023-02-11 14:18:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Redirects:_New_or_Edit', 'help', 'nl', 'redirect', 'redirects-new-or-edit.md', 'Verwijzingen: Nieuw of bewerken', '2023-02-11 14:18:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration', 'help', 'nl', 'site', 'site-global-configuration.md', 'Algemene instellingen', '2023-02-11 14:18:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Logging', 'help', 'nl', 'site', 'site-global-configuration-logging.md', 'Algemene instellingen: Loggen', '2023-02-11 14:18:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Permissions', 'help', 'nl', 'site', 'site-global-configuration-permissions.md', 'Algemene instellingen: Rechten', '2023-02-11 14:18:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Server', 'help', 'nl', 'site', 'site-global-configuration-server.md', 'Algemene instellingen: Server', '2023-02-11 14:18:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Site', 'help', 'nl', 'site', 'site-global-configuration-site.md', 'Algemene instellingen: Website', '2023-02-11 14:18:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_System', 'help', 'nl', 'site', 'site-global-configuration-system.md', 'Algemene instellingen: Systeem', '2023-02-11 14:18:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Text_Filters', 'help', 'nl', 'site', 'site-global-configuration-text-filters.md', 'Algemene instellingen: Tekstfilters', '2023-02-11 14:18:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_System_Information', 'help', 'nl', 'site', 'site-system-information.md', 'Site Systeem informatie', '2023-02-11 14:18:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Archived', 'help', 'nl', 'site-modules', 'site-modules-articles-archived.md', 'Site modules: Gearchiveerde artikelen', '2023-02-11 14:18:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Categories', 'help', 'nl', 'site-modules', 'site-modules-articles-categories.md', 'Site modules: Artikelen - Categorieën', '2023-02-11 14:18:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Category', 'help', 'nl', 'site-modules', 'site-modules-articles-category.md', 'Site modules: Artikelen - Categorie', '2023-02-11 14:18:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Latest', 'help', 'nl', 'site-modules', 'site-modules-articles-latest.md', 'Site modules: Artikelen - Nieuwste', '2023-02-11 14:18:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Most_Read', 'help', 'nl', 'site-modules', 'site-modules-articles-most-read.md', 'Site modules: Meest gelezen artikelen', '2023-02-11 14:18:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Newsflash', 'help', 'nl', 'site-modules', 'site-modules-articles-newsflash.md', 'Site modules: Artikelen - Nieuwsflash', '2023-02-11 14:18:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Related', 'help', 'nl', 'site-modules', 'site-modules-articles-related.md', 'Site modules: Gerelateerde artikelen', '2023-02-11 14:18:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Banners', 'help', 'nl', 'site-modules', 'site-modules-banners.md', 'Site modules: Advertenties', '2023-02-11 14:19:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Breadcrumbs', 'help', 'nl', 'site-modules', 'site-modules-breadcrumbs.md', 'Site modules: Kruimelpaden', '2023-02-11 14:19:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Custom', 'help', 'nl', 'site-modules', 'site-modules-custom.md', 'Site modules: Aangepast', '2023-02-11 14:19:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Feed_Display', 'help', 'nl', 'site-modules', 'site-modules-feed-display.md', 'Site modules: Nieuwsfeed tonen', '2023-02-11 14:19:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Footer', 'help', 'nl', 'site-modules', 'site-modules-footer.md', 'Site modules: Voettekst', '2023-02-11 14:19:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Language_Switcher', 'help', 'nl', 'site-modules', 'site-modules-language-switcher.md', 'Site modules: Taalselectie', '2023-02-11 14:19:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Latest_Users', 'help', 'nl', 'site-modules', 'site-modules-latest-users.md', 'Site modules: Nieuwste gebruikers', '2023-02-11 14:19:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Login', 'help', 'nl', 'site-modules', 'site-modules-login.md', 'Site modules: Inloggen', '2023-02-11 14:19:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Menu', 'help', 'nl', 'site-modules', 'site-modules-menu.md', 'Site modules: Menu', '2023-02-11 14:19:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Random_Image', 'help', 'nl', 'site-modules', 'site-modules-random-image.md', 'Site modules: Willekeurige afbeelding', '2023-02-11 14:19:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Smart_Search', 'help', 'nl', 'site-modules', 'site-modules-smart-search.md', 'Site modules: Slimzoeken', '2023-02-11 14:19:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Statistics', 'help', 'nl', 'site-modules', 'site-modules-statistics.md', 'Site modules: Statistieken', '2023-02-11 14:19:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Syndication_Feeds', 'help', 'nl', 'site-modules', 'site-modules-syndication-feeds.md', 'Site modules: Syndication feeds', '2023-02-11 14:19:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Tags_-_Popular', 'help', 'nl', 'site-modules', 'site-modules-tags-popular.md', 'Site module: Populaire tags', '2023-02-11 14:19:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Tags_-_Similar', 'help', 'nl', 'site-modules', 'site-modules-tags-similar.md', 'Site modules: Gelijksoortige tags', '2023-02-11 14:19:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Who''s_Online', 'help', 'nl', 'site-modules', 'site-modules-whos-online.md', 'Site modules: Wie is online', '2023-02-11 14:19:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Wrapper', 'help', 'nl', 'site-modules', 'site-modules-wrapper.md', 'Site modules: Wrapper', '2023-02-11 14:19:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Content_Maps', 'help', 'nl', 'smart-search', 'smart-search-content-maps.md', 'Slim zoeken: Inhoudsschema''s', '2023-02-11 14:19:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Indexed_Content', 'help', 'nl', 'smart-search', 'smart-search-indexed-content.md', 'Slim zoeken: Geïndexeerde inhoud', '2023-02-11 14:19:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_New_or_Edit_Filter', 'help', 'nl', 'smart-search', 'smart-search-new-or-edit-filter.md', 'Slim zoeken: Nieuw of bewerk filter', '2023-02-11 14:19:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Options', 'help', 'nl', 'smart-search', 'smart-search-options.md', 'Slim zoeken - Opties', '2023-02-11 14:19:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Search_Filters', 'help', 'nl', 'smart-search', 'smart-search-search-filters.md', 'Slim zoeken: Zoekfilters', '2023-02-11 14:19:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Search_Term_Analysis', 'help', 'nl', 'smart-search', 'smart-search-search-term-analysis.md', 'Slim zoeken: Zoekterm-analyse', '2023-02-11 14:19:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Tags', 'help', 'nl', 'tags', 'tags.md', 'Tags', '2023-02-11 14:19:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Tags:_New_or_Edit', 'help', 'nl', 'tags', 'tags-new-or-edit.md', 'Tags: - Nieuw of bewerken', '2023-02-11 14:19:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Tags:_Options', 'help', 'nl', 'tags', 'tags-options.md', 'Tags: Opties', '2023-02-11 14:19:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Template:_Options', 'help', 'nl', 'templates', 'template-options.md', 'Template: Opties', '2023-02-11 14:20:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Customise', 'help', 'nl', 'templates', 'templates-customise.md', 'Templates: Bewerken', '2023-02-11 14:20:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Edit_Style', 'help', 'nl', 'templates', 'templates-edit-style.md', 'Templates: Bewerk stijl', '2023-02-11 14:20:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Styles', 'help', 'nl', 'templates', 'templates-styles.md', 'Templates: Stijlen', '2023-02-11 14:20:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Templates', 'help', 'nl', 'templates', 'templates-templates.md', 'Templates: Templates', '2023-02-11 14:20:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Stages_List:_Basic_Workflow', 'help', 'nl', 'workflow', 'stages-list-basic-workflow.md', 'Fases lijst: Basis workflow', '2023-02-11 14:20:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Transitions_List:_Basic_Workflow', 'help', 'nl', 'workflow', 'transitions-list-basic-workflow.md', 'Transities lijst: Basis workflow', '2023-02-11 14:20:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Workflows_List', 'help', 'nl', 'workflow', 'workflows-list.md', 'Workflow lijsten', '2023-02-11 14:20:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Edit_Update_Site', 'help', 'nl', 'update-sites', 'edit-update-site.md', 'Update site', '2023-02-11 14:20:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Update_Sites', 'help', 'nl', 'update-sites', 'extensions-update-sites.md', 'Extensies: Updatesites', '2023-02-11 14:20:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Actions_Log', 'help', 'nl', 'users', 'user-actions-log.md', 'Gebruiker actielog', '2023-02-11 14:20:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Actions_Log:_Options', 'help', 'nl', 'users', 'user-actions-log-options.md', 'Gebruikersacties log: Opties', '2023-02-11 14:20:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes', 'help', 'nl', 'users', 'user-notes.md', 'Gebruikersnotities', '2023-02-11 14:20:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes:_Categories', 'help', 'nl', 'users', 'user-notes-categories.md', 'Gebruikersnotities: Categorieën', '2023-02-11 14:20:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes:_New_or_Edit', 'help', 'nl', 'users', 'user-notes-new-or-edit.md', 'Gebruikersnotities: Nieuw of bewerken', '2023-02-11 14:20:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes:_New_or_Edit_Category', 'help', 'nl', 'users', 'user-notes-new-or-edit-category.md', 'Gebruikersnotities: Nieuw of bewerken van categorieën', '2023-02-11 14:20:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users', 'help', 'nl', 'users', 'users.md', 'Gebruikers', '2023-02-11 14:20:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Edit_Profile', 'help', 'nl', 'users', 'users-edit-profile.md', 'Gebruikers: Bewerk profiel', '2023-02-11 14:20:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Edit_Viewing_Access_Level', 'help', 'nl', 'users', 'users-edit-viewing-access-level.md', 'Gebruikers: Toegangsniveaus bekijken bewerken', '2023-02-11 14:20:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Groups', 'help', 'nl', 'users', 'users-groups.md', 'Gebruikers: Groepen', '2023-02-11 14:20:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_New_or_Edit_Group', 'help', 'nl', 'users', 'users-new-or-edit-group.md', 'Gebruikers: Nieuwe groep of bewerken', '2023-02-11 14:20:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Options', 'help', 'nl', 'users', 'users-options.md', 'Gebruikers: Opties', '2023-02-11 14:20:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Viewing_Access_Levels', 'help', 'nl', 'users', 'users-viewing-access-levels.md', 'Gebruikers: Toegangsniveaus bekijken', '2023-02-11 14:20:52') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Edit', 'help', 'pt-br', 'articles', 'articles-edit.md', 'Ajuda4.x:Artigos: Editar', '2023-02-11 14:27:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Featured', 'help', 'pt-br', 'articles', 'articles-featured.md', 'Ajuda4.x:Artigos: Destacados', '2023-02-11 14:27:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Options', 'help', 'pt-br', 'articles', 'articles-options.md', 'Ajuda4.x:Artigos: Opções', '2023-02-11 14:27:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners', 'help', 'pt-br', 'banners', 'banners.md', 'Ajuda4.x:Banners', '2023-02-11 14:27:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Categories', 'help', 'pt-br', 'banners', 'banners-categories.md', 'Ajuda4.x:Banners: Categorias', '2023-02-11 14:27:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Clients', 'help', 'pt-br', 'banners', 'banners-clients.md', 'Ajuda4.x:Banners: Clientes', '2023-02-11 14:27:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Edit', 'help', 'pt-br', 'banners', 'banners-edit.md', 'Banners: Editar', '2023-02-11 14:27:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_New_or_Edit_Category', 'help', 'pt-br', 'banners', 'banners-new-or-edit-category.md', 'Ajuda4.x:Banners: Nova categoria ou editar categoria', '2023-02-11 14:27:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_New_or_Edit_Client', 'help', 'pt-br', 'banners', 'banners-new-or-edit-client.md', 'Ajuda4.x:Banners: Novo cliente ou editar cliente', '2023-02-11 14:27:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Options', 'help', 'pt-br', 'banners', 'banners-options.md', 'Ajuda4.x:Banners: Opções', '2023-02-11 14:27:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Banners:_Tracks', 'help', 'pt-br', 'banners', 'banners-tracks.md', 'Ajuda4.x:Banners: Monitoramentos', '2023-02-11 14:27:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Components_Version_History', 'help', 'pt-br', 'components', 'components-version-history.md', 'Histórico de versões de componentes', '2023-02-11 14:28:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Editors', 'help', 'pt-br', 'editors', 'editors.md', 'Ajuda4.x:Editores', '2023-02-11 14:28:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Fields:_Edit', 'help', 'pt-br', 'fields', 'fields-edit.md', 'Ajuda4.x:Campos: Editar', '2023-02-11 14:28:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media', 'help', 'pt-br', 'media', 'media.md', 'Ajuda4.x:Mídia', '2023-02-11 14:29:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media:_Options', 'help', 'pt-br', 'media', 'media-options.md', 'Ajuda4.x:Mídia: Opções', '2023-02-11 14:29:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Article_Archived', 'help', 'pt-br', 'menu-items', 'menu-item-article-archived.md', 'Ajuda4.x:Item dos menus: Artigos arquivados', '2023-02-11 14:29:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Create_Article', 'help', 'pt-br', 'menu-items', 'menu-item-create-article.md', 'Ajuda4.x:Item dos menus: Criar artigo', '2023-02-11 14:29:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Featured_Articles', 'help', 'pt-br', 'menu-items', 'menu-item-featured-articles.md', 'Ajuda4.x:Item dos menus: Artigos destacados', '2023-02-11 14:29:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_New_Item', 'help', 'pt-br', 'menu-items', 'menu-item-new-item.md', 'Ajuda4.x:Item dos menus: Novo item', '2023-02-11 14:29:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Single_Article', 'help', 'pt-br', 'menu-items', 'menu-item-single-article.md', 'Ajuda4.x:Item dos menus: Artigo único', '2023-02-11 14:29:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus', 'help', 'pt-br', 'menus', 'menus.md', 'Menus/pt-br', '2023-02-11 14:29:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Items', 'help', 'pt-br', 'menus', 'menus-items.md', 'Ajuda4.x:Menus: Itens', '2023-02-11 14:29:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus:_Options', 'help', 'pt-br', 'menus', 'menus-options.md', 'Ajuda4.x:Menus: Opções', '2023-02-11 14:29:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Modules', 'help', 'pt-br', 'modules', 'modules.md', 'Módulos', '2023-02-11 14:30:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations', 'help', 'pt-br', 'multilingual-associations', 'multilingual-associations.md', 'Ajuda4.x:Associações multilíngues', '2023-02-11 14:30:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Edit', 'help', 'pt-br', 'multilingual-associations', 'multilingual-associations-edit.md', 'Ajuda4.x:Associações multilíngues: Editar', '2023-02-11 14:30:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Options', 'help', 'pt-br', 'multilingual-associations', 'multilingual-associations-options.md', 'Ajuda4.x:Associações multilíngues: Opções', '2023-02-11 14:30:17') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:News_Feed:_Options', 'help', 'pt-br', 'news-feed', 'news-feed-options.md', 'Ajuda4.x:Feed para notícias: Opções', '2023-02-11 14:30:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:News_Feeds', 'help', 'pt-br', 'news-feed', 'news-feeds.md', 'Ajuda4.x:Feeds para notícias', '2023-02-11 14:30:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:News_Feeds:_Categories', 'help', 'pt-br', 'news-feed', 'news-feeds-categories.md', 'Ajuda4.x:Feeds para notícias: Categorias', '2023-02-11 14:30:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:News_Feeds:_New_or_Edit', 'help', 'pt-br', 'news-feed', 'news-feeds-new-or-edit.md', 'News Feeds: Edit/pt-br', '2023-02-11 14:30:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration', 'help', 'pt-br', 'site', 'site-global-configuration.md', 'Site Global Configuration/pt-br', '2023-02-11 14:30:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Archived', 'help', 'pt-br', 'site-modules', 'site-modules-articles-archived.md', 'Ajuda4.x:Módulos do site: Artigos - Arquivados', '2023-02-11 14:31:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Categories', 'help', 'pt-br', 'site-modules', 'site-modules-articles-categories.md', 'Ajuda4.x:Módulos do site: Artigos - Categorias', '2023-02-11 14:31:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Category', 'help', 'pt-br', 'site-modules', 'site-modules-articles-category.md', 'Ajuda4.x:Módulos do site: Artigos - Categoria', '2023-02-11 14:31:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Latest', 'help', 'pt-br', 'site-modules', 'site-modules-articles-latest.md', 'Ajuda4.x:Módulos do site: Artigos - Mais recentes', '2023-02-11 14:31:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Most_Read', 'help', 'pt-br', 'site-modules', 'site-modules-articles-most-read.md', 'Módulos do site: Artigos - Mais lidos', '2023-02-11 14:31:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Newsflash', 'help', 'pt-br', 'site-modules', 'site-modules-articles-newsflash.md', 'Módulos do site: Artigos - Novidades', '2023-02-11 14:31:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Articles_-_Related', 'help', 'pt-br', 'site-modules', 'site-modules-articles-related.md', 'Módulos do site: Artigos - Relacionados', '2023-02-11 14:31:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Banners', 'help', 'pt-br', 'site-modules', 'site-modules-banners.md', 'Ajuda4.x:Módulos do site: Banners', '2023-02-11 14:31:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Breadcrumbs', 'help', 'pt-br', 'site-modules', 'site-modules-breadcrumbs.md', 'Ajuda4.x:Módulos do site: Trilha da navegação', '2023-02-11 14:31:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Custom', 'help', 'pt-br', 'site-modules', 'site-modules-custom.md', 'Ajuda4.x:Módulos do site: Personalizado', '2023-02-11 14:31:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Feed_Display', 'help', 'pt-br', 'site-modules', 'site-modules-feed-display.md', 'Ajuda4.x:Módulos do site: Exibição para feed', '2023-02-11 14:31:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Footer', 'help', 'pt-br', 'site-modules', 'site-modules-footer.md', 'Ajuda4.x:Módulos do site: Rodapé', '2023-02-11 14:31:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Language_Switcher', 'help', 'pt-br', 'site-modules', 'site-modules-language-switcher.md', 'Ajuda4.x:Módulos do site: Alternador para linguagens', '2023-02-11 14:31:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Latest_Users', 'help', 'pt-br', 'site-modules', 'site-modules-latest-users.md', 'Ajuda4.x:Módulos do site: Usuários mais recentes', '2023-02-11 14:31:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Login', 'help', 'pt-br', 'site-modules', 'site-modules-login.md', 'Ajuda4.x:Módulos do site: Sessões', '2023-02-11 14:31:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Menu', 'help', 'pt-br', 'site-modules', 'site-modules-menu.md', 'Ajuda4.x:Módulos do site: Menus', '2023-02-11 14:31:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Random_Image', 'help', 'pt-br', 'site-modules', 'site-modules-random-image.md', 'Ajuda4.x:Módulos do site: Imagem aleatória', '2023-02-11 14:31:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Smart_Search', 'help', 'pt-br', 'site-modules', 'site-modules-smart-search.md', 'Ajuda4.x:Módulos do site: Pesquisa inteligente', '2023-02-11 14:31:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Statistics', 'help', 'pt-br', 'site-modules', 'site-modules-statistics.md', 'Ajuda4.x:Módulos do site: Estatísticas', '2023-02-11 14:31:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Syndication_Feeds', 'help', 'pt-br', 'site-modules', 'site-modules-syndication-feeds.md', 'Ajuda4.x:Módulos do site: Feeds para distribuição', '2023-02-11 14:31:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Tags_-_Popular', 'help', 'pt-br', 'site-modules', 'site-modules-tags-popular.md', 'Ajuda4.x:Módulos do site: Tags - Populares', '2023-02-11 14:31:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Tags_-_Similar', 'help', 'pt-br', 'site-modules', 'site-modules-tags-similar.md', 'Ajuda4.x:Módulos do site: Tags - Similares', '2023-02-11 14:31:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Who''s_Online', 'help', 'pt-br', 'site-modules', 'site-modules-whos-online.md', 'Ajuda4.x:Módulos do site: Quem está online', '2023-02-11 14:31:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Wrapper', 'help', 'pt-br', 'site-modules', 'site-modules-wrapper.md', 'Ajuda4.x:Módulos do site: Invólucro', '2023-02-11 14:31:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Actions_Log', 'help', 'pt-br', 'users', 'user-actions-log.md', 'Ajuda4.x:Registros das ações dos usuários', '2023-02-11 14:32:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes', 'help', 'pt-br', 'users', 'user-notes.md', 'Notas de usuários', '2023-02-11 14:32:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes:_Categories', 'help', 'pt-br', 'users', 'user-notes-categories.md', 'Notas de usuários: Categorias', '2023-02-11 14:32:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:User_Notes:_New_or_Edit', 'help', 'pt-br', 'users', 'user-notes-new-or-edit.md', 'Notas de usuários: Nova ou Editar', '2023-02-11 14:32:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users', 'help', 'pt-br', 'users', 'users.md', 'Usuários', '2023-02-11 14:32:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Edit_Profile', 'help', 'pt-br', 'users', 'users-edit-profile.md', 'Ajuda4.x:Usuários: Editar perfil', '2023-02-11 14:32:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Edit_Viewing_Access_Level', 'help', 'pt-br', 'users', 'users-edit-viewing-access-level.md', 'Usuários: Editar níveis de acesso de visualização', '2023-02-11 14:32:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Groups', 'help', 'pt-br', 'users', 'users-groups.md', 'Ajuda 4.x:Usuários: Grupos', '2023-02-11 14:32:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_New_or_Edit_Group', 'help', 'pt-br', 'users', 'users-new-or-edit-group.md', 'Usuários: Novo/editar grupo', '2023-02-11 14:32:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Options', 'help', 'pt-br', 'users', 'users-options.md', 'Usuários: Opções', '2023-02-11 14:32:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Viewing_Access_Levels', 'help', 'pt-br', 'users', 'users-viewing-access-levels.md', 'Usuários: Níveis de acesso de visualização', '2023-02-11 14:32:43') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles', 'help', 'pt', 'articles', 'articles.md', 'Artigos', '2023-02-11 14:21:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Edit', 'help', 'pt', 'articles', 'articles-edit.md', 'Artigo - Editar', '2023-02-11 14:21:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Install', 'help', 'pt', 'extensions', 'extensions-install.md', 'Extensões - Instalação do Gestor de Extensões', '2023-02-11 14:22:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Update', 'help', 'pt', 'extensions', 'extensions-update.md', 'Extensões - Atualização do Gestor de Extensões', '2023-02-11 14:22:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Content', 'help', 'pt', 'languages', 'languages-content.md', 'Conteúdo do Gestor de Idiomas das Extensões', '2023-02-11 14:22:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Edit_Override', 'help', 'pt', 'languages', 'languages-edit-override.md', 'Substituição de Edição do Gestor de Idiomas das Extensões', '2023-02-11 14:22:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Installed', 'help', 'pt', 'languages', 'languages-installed.md', 'Gestor de Idiomas das Extensões Instalado', '2023-02-11 14:23:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_Content_Maps', 'help', 'pt', 'smart-search', 'smart-search-content-maps.md', 'Smart Search: Content Maps', '2023-02-11 14:24:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Smart_Search:_New_or_Edit_Filter', 'help', 'pt', 'smart-search', 'smart-search-new-or-edit-filter.md', 'Editar Filtros de Pesquisa do Gestor de Localização de Componentes', '2023-02-11 14:24:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Options', 'help', 'pt', 'users', 'users-options.md', 'Utilizadores: Opções', '2023-02-11 14:25:23') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Login_Support_Information', 'help', 'ru', 'admin-modules', 'admin-modules-login-support-information.md', 'Admin Modules: Login Support Information', '2023-02-11 14:33:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles', 'help', 'ru', 'articles', 'articles.md', 'Материалы', '2023-02-11 14:33:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Categories', 'help', 'ru', 'articles', 'articles-categories.md', 'Материалы: Категории', '2023-02-11 14:33:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Edit', 'help', 'ru', 'articles', 'articles-edit.md', 'Материалы: Создание материала', '2023-02-11 14:33:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Featured', 'help', 'ru', 'articles', 'articles-featured.md', 'Избранные материалы', '2023-02-11 14:33:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Articles:_Options', 'help', 'ru', 'articles', 'articles-options.md', 'Материалы: Настройки', '2023-02-11 14:33:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Install', 'help', 'ru', 'extensions', 'extensions-install.md', 'Расширения: Установка', '2023-02-11 14:34:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Extensions:_Languages', 'help', 'ru', 'extensions', 'extensions-languages.md', 'Extensions: Languages', '2023-02-11 14:34:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Fields:_Edit', 'help', 'ru', 'fields', 'fields-edit.md', 'Материалы: Редактирование поля', '2023-02-11 14:34:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Languages:_Installed', 'help', 'ru', 'languages', 'languages-installed.md', 'Языки: Установленные языки', '2023-02-11 14:34:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Maintenance:_Clear_Cache', 'help', 'ru', 'mail', 'maintenance-clear-cache.md', 'Техническое обслуживание: Очистка кэша', '2023-02-11 14:34:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Maintenance:_Global_Check-in', 'help', 'ru', 'mail', 'maintenance-global-check-in.md', 'Техническое обслуживание: Снятие блокировок', '2023-02-11 14:35:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media', 'help', 'ru', 'media', 'media.md', 'Медиа-менеджер', '2023-02-11 14:35:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Media:_Options', 'help', 'ru', 'media', 'media-options.md', 'Медиа-менеджер: Настройки', '2023-02-11 14:35:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Article_Archived', 'help', 'ru', 'menu-items', 'menu-item-article-archived.md', 'Меню: Материалы в архиве', '2023-02-11 14:35:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Category_Blog', 'help', 'ru', 'menu-items', 'menu-item-category-blog.md', 'Меню: Блог категории', '2023-02-11 14:35:12') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Category_List', 'help', 'ru', 'menu-items', 'menu-item-category-list.md', 'Меню: Материалы', '2023-02-11 14:35:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Create_Article', 'help', 'ru', 'menu-items', 'menu-item-create-article.md', 'Меню: Создать материал', '2023-02-11 14:35:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Featured_Articles', 'help', 'ru', 'menu-items', 'menu-item-featured-articles.md', 'Меню: Избранные материалы', '2023-02-11 14:35:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_List_All_Categories', 'help', 'ru', 'menu-items', 'menu-item-list-all-categories.md', 'Меню: Категории', '2023-02-11 14:35:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_New_Item', 'help', 'ru', 'menu-items', 'menu-item-new-item.md', 'Меню: Создание пункта меню', '2023-02-11 14:35:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menu_Item:_Single_Article', 'help', 'ru', 'menu-items', 'menu-item-single-article.md', 'Меню: Материал', '2023-02-11 14:35:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Menus', 'help', 'ru', 'menus', 'menus.md', 'Меню', '2023-02-11 14:35:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Modules', 'help', 'ru', 'modules', 'modules.md', 'Модули', '2023-02-11 14:36:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations', 'help', 'ru', 'multilingual-associations', 'multilingual-associations.md', 'Многоязычные связи', '2023-02-11 14:36:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Edit', 'help', 'ru', 'multilingual-associations', 'multilingual-associations-edit.md', 'Многоязычные связи: Редактирование', '2023-02-11 14:36:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Multilingual_Associations:_Options', 'help', 'ru', 'multilingual-associations', 'multilingual-associations-options.md', 'Многоязычные связи: Настройки', '2023-02-11 14:36:15') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Plugins', 'help', 'ru', 'plugins', 'plugins.md', 'Плагины', '2023-02-11 14:36:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration', 'help', 'ru', 'site', 'site-global-configuration.md', 'Общие настройки', '2023-02-11 14:36:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Logging', 'help', 'ru', 'site', 'site-global-configuration-logging.md', 'Общие настройки: Логирование', '2023-02-11 14:36:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Permissions', 'help', 'ru', 'site', 'site-global-configuration-permissions.md', 'Общие настройки: Права доступа', '2023-02-11 14:36:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Server', 'help', 'ru', 'site', 'site-global-configuration-server.md', 'Общие настройки: Сервер', '2023-02-11 14:36:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Site', 'help', 'ru', 'site', 'site-global-configuration-site.md', 'Общие настройки: Параметры сайта', '2023-02-11 14:36:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_System', 'help', 'ru', 'site', 'site-global-configuration-system.md', 'Общие настройки: Система', '2023-02-11 14:36:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Global_Configuration_Text_Filters', 'help', 'ru', 'site', 'site-global-configuration-text-filters.md', 'Общие настройки: Фильтры текста', '2023-02-11 14:36:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Banners', 'help', 'ru', 'site-modules', 'site-modules-banners.md', 'Site Modules: Banners', '2023-02-11 14:37:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Breadcrumbs', 'help', 'ru', 'site-modules', 'site-modules-breadcrumbs.md', 'Site Modules: Breadcrumbs', '2023-02-11 14:37:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Custom', 'help', 'ru', 'site-modules', 'site-modules-custom.md', 'Модули: HTML-код', '2023-02-11 14:37:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Site_Modules:_Menu', 'help', 'ru', 'site-modules', 'site-modules-menu.md', 'Site Modules: Menu', '2023-02-11 14:37:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Templates:_Styles', 'help', 'ru', 'templates', 'templates-styles.md', 'Шаблоны: Стили', '2023-02-11 14:37:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users', 'help', 'ru', 'users', 'users.md', 'Пользователи', '2023-02-11 14:37:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Users:_Viewing_Access_Levels', 'help', 'ru', 'users', 'users-viewing-access-levels.md', 'Пользователи: Уровни доступа', '2023-02-11 14:37:56') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developer:_Required_Software', 'developer', 'en', 'getting-started', 'developer-required-software.md', 'Developer: Required Software', '2023-02-12 09:18:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('XAMPP', 'developer', 'en', 'getting-started', 'xampp.md', 'XAMPP', '2023-02-12 09:18:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Apache_PHP_Handler', 'developer', 'en', 'getting-started', 'apache-php-handler.md', 'Apache PHP Handler', '2023-02-12 09:18:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developer:_File_Structure', 'developer', 'en', 'getting-started', 'developer-file-structure.md', 'Developer: File Structure', '2023-02-12 09:18:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Visual_Studio_Code_Primer', 'developer', 'en', 'getting-started', 'visual-studio-code-primer.md', 'Visual Studio Code Primer', '2023-02-12 09:18:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developer:_Eclipse_PDT', 'developer', 'en', 'getting-started', 'developer-eclipse-pdt.md', 'Developer: Eclipse PDT', '2023-02-12 09:18:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Setting_Up_Your_Local_Environment', 'developer', 'en', 'developer-information', 'setting-up-your-local-environment.md', 'Setting Up Your Local Environment', '2023-02-12 09:18:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Working_with_git_and_github', 'developer', 'en', 'developer-information', 'working-with-git-and-github.md', 'Working with git and github', '2023-02-12 09:18:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Setting_up_Eclipse_PDT_2020_and_Git_for_Pulls', 'developer', 'en', 'developer-information', 'setting-up-eclipse-pdt-2020-and-git-for-pulls.md', 'Setting up Eclipse PDT 2020 and Git for Pulls', '2023-02-12 09:18:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Manifest_files', 'developer', 'en', 'developer-information', 'manifest-files.md', 'Manifest files', '2023-02-12 09:18:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Namespace_Conventions_In_Joomla', 'developer', 'en', 'developer-information', 'namespace-conventions-in-joomla.md', 'Namespace Conventions In Joomla', '2023-02-12 09:18:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Web_Assets', 'developer', 'en', 'developer-information', 'web-assets.md', 'Web Assets', '2023-02-12 09:18:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Dependency_Injection_in_Joomla_4', 'developer', 'en', 'developer-information', 'dependency-injection-in-joomla-4.md', 'Dependency Injection in Joomla 4', '2023-02-12 09:18:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Core_APIs', 'developer', 'en', 'developer-information', 'joomla-core-apis.md', 'Joomla Core APIs', '2023-02-12 09:18:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('API_Guides', 'developer', 'en', 'developer-information', 'api-guides.md', 'API Guides', '2023-02-12 09:18:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Deploying_an_Update_Server', 'developer', 'en', 'developer-information', 'deploying-an-update-server.md', 'Deploying an Update Server', '2023-02-12 09:18:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_CodeSniffer', 'developer', 'en', 'developer-information', 'joomla-codesniffer.md', 'Joomla CodeSniffer', '2023-02-12 09:19:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_a_Plugin_for_Joomla', 'developer', 'en', 'plugin-development', 'creating-a-plugin-for-joomla.md', 'Creating a Plugin for Joomla', '2023-02-12 09:19:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_an_Authentication_Plugin_for_Joomla', 'developer', 'en', 'plugin-development', 'creating-an-authentication-plugin-for-joomla.md', 'Creating an Authentication Plugin for Joomla', '2023-02-12 09:19:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Creating_a_Smart_Search_plug-in', 'developer', 'en', 'plugin-development', 'creating-a-smart-search-plug-in.md', 'Creating a Smart Search plug-in', '2023-02-12 09:19:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Triggering_content_plugins_in_your_extension', 'developer', 'en', 'plugin-development', 'triggering-content-plugins-in-your-extension.md', 'Triggering content plugins in your extension', '2023-02-12 09:19:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Cloud_File_Systems_for_Media_Manager', 'developer', 'en', 'plugin-development', 'cloud-file-systems-for-media-manager.md', 'Cloud File Systems for Media Manager', '2023-02-12 09:19:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:J4_Plugin_example_-_Table_of_Contents', 'developer', 'en', 'plugin-development', 'j4-plugin-example-table-of-contents.md', 'J4 Plugin example - Table of Contents', '2023-02-12 09:19:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_a_Simple_Module', 'developer', 'en', 'module-development', 'creating-a-simple-module.md', 'Creating a Simple Module', '2023-02-12 09:19:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:J4_Module_example_-_Mydownmsg', 'developer', 'en', 'module-development', 'j4-module-example-mydownmsg.md', 'J4 Module example - Mydownmsg', '2023-02-12 09:19:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component', 'developer', 'en', 'developing-an-mvc-component', 'developing-an-mvc-component.md', 'Developing an MVC Component', '2023-02-12 09:19:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component/Introduction', 'developer', 'en', 'developing-an-mvc-component', 'developing-an-mvc-component-introduction.md', 'Developing an MVC Component/Introduction', '2023-02-12 09:19:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component/Developing_a_Basic_Component', 'developer', 'en', 'developing-an-mvc-component', 'developing-an-mvc-component-developing-a-basic-component.md', 'Developing an MVC Component/Developing a Basic Component', '2023-02-12 09:19:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component/Adding_a_View_to_the_Site_Part', 'developer', 'en', 'developing-an-mvc-component', 'developing-an-mvc-component-adding-a-view-to-the-site-part.md', 'Developing an MVC Component/Adding a View to the Site Part', '2023-02-12 09:19:32') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component/Adding_a_Menu_Type_to_the_Site_Part', 'developer', 'en', 'developing-an-mvc-component', 'developing-an-mvc-component-adding-a-menu-type-to-the-site-part.md', 'Developing an MVC Component/Adding a Menu Type to the Site Part', '2023-02-12 09:19:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component/Language_Management', 'developer', 'en', 'developing-an-mvc-component', 'developing-an-mvc-component-language-management.md', 'Developing an MVC Component/Language Management', '2023-02-12 09:19:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component/Adding_a_Model_to_the_Site_Part', 'developer', 'en', 'developing-an-mvc-component', 'developing-an-mvc-component-adding-a-model-to-the-site-part.md', 'Developing an MVC Component/Adding a Model to the Site Part', '2023-02-12 09:19:39') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component/Adding_a_Request_Variable_in_the_Menu_Link', 'developer', 'en', 'developing-an-mvc-component', 'developing-an-mvc-component-adding-a-request-variable-in-the-menu-link.md', 'Developing an MVC Component/Adding a Request Variable in the Menu Link', '2023-02-12 09:19:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component/Setting_up_the_Database', 'developer', 'en', 'developing-an-mvc-component', 'developing-an-mvc-component-setting-up-the-database.md', 'Developing an MVC Component/Setting up the Database', '2023-02-12 09:19:44') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_an_API_to_a_Joomla_Component', 'developer', 'en', 'developing-an-mvc-component', 'adding-an-api-to-a-joomla-component.md', 'Adding an API to a Joomla Component', '2023-02-12 09:19:47') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:MVC_Anatomy:_Getting_Started', 'developer', 'en', 'mvc-anatomy', 'mvc-anatomy-getting-started.md', 'MVC Anatomy: Getting Started', '2023-02-12 09:19:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:MVC_Anatomy:_File_Structure', 'developer', 'en', 'mvc-anatomy', 'mvc-anatomy-file-structure.md', 'MVC Anatomy: File Structure', '2023-02-12 09:19:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:MVC_Anatomy:_Manifest_File', 'developer', 'en', 'mvc-anatomy', 'mvc-anatomy-manifest-file.md', 'MVC Anatomy: Manifest File', '2023-02-12 09:19:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:MVC_Anatomy:_Site_Files', 'developer', 'en', 'mvc-anatomy', 'mvc-anatomy-site-files.md', 'MVC Anatomy: Site Files', '2023-02-12 09:19:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:MVC_Anatomy:_Administrator_Startup_Files', 'developer', 'en', 'mvc-anatomy', 'mvc-anatomy-administrator-startup-files.md', 'MVC Anatomy: Administrator Startup Files', '2023-02-12 09:19:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:MVC_Anatomy:_Administrator_Edit_Files', 'developer', 'en', 'mvc-anatomy', 'mvc-anatomy-administrator-edit-files.md', 'MVC Anatomy: Administrator Edit Files', '2023-02-12 09:20:03') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:J4_Component_example_-_Mywalks', 'developer', 'en', 'mvc-examples', 'j4-component-example-mywalks.md', 'J4 Component example - Mywalks', '2023-02-12 09:20:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:My_Walks_Part_1:_The_Site_code', 'developer', 'en', 'mvc-examples', 'my-walks-part-1-the-site-code.md', 'My Walks Part 1: The Site code', '2023-02-12 09:20:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:My_Walks_Part_2:_The_Administrator_code', 'developer', 'en', 'mvc-examples', 'my-walks-part-2-the-administrator-code.md', 'My Walks Part 2: The Administrator code', '2023-02-12 09:20:13') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:J4_Developer_Resources', 'developer', 'en', 'mvc-examples', 'j4-developer-resources.md', 'J4 Developer Resources', '2023-02-12 09:20:19') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Writing_A_CLI_Application', 'developer', 'en', 'cli-development', 'writing-a-cli-application.md', 'Writing A CLI Application', '2023-02-12 09:20:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:CLI_Database_Exporter_Importer', 'developer', 'en', 'cli-development', 'cli-database-exporter-importer.md', 'CLI Database Exporter Importer', '2023-02-12 09:20:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:CLI_Update', 'developer', 'en', 'cli-development', 'cli-update.md', 'CLI Update', '2023-02-12 09:20:27') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:CLI_example_-_Onoffbydate', 'developer', 'en', 'cli-development', 'cli-example-onoffbydate.md', 'CLI example - Onoffbydate', '2023-02-12 09:20:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Moving_Joomla_To_Prepared_Statements', 'developer', 'en', 'database', 'moving-joomla-to-prepared-statements.md', 'Moving Joomla To Prepared Statements', '2023-02-12 09:20:36') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Selecting_data_using_JDatabase', 'developer', 'en', 'database', 'selecting-data-using-jdatabase.md', 'Selecting data using JDatabase', '2023-02-12 09:20:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Inserting_Updating_and_Removing_data_using_JDatabase', 'developer', 'en', 'database', 'inserting-updating-and-removing-data-using-jdatabase.md', 'Inserting Updating and Removing data using JDatabase', '2023-02-12 09:20:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Tips_and_Tricks_for_Joomla_4_Developers', 'developer', 'en', 'coding-examples', 'tips-and-tricks-for-joomla-4-developers.md', 'Tips and Tricks for Joomla 4 Developers', '2023-02-12 09:20:46') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Using_Bootstrap_Components_in_Joomla_4', 'developer', 'en', 'coding-examples', 'using-bootstrap-components-in-joomla-4.md', 'Using Bootstrap Components in Joomla 4', '2023-02-12 09:20:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Automated_System_Testing', 'developer', 'en', 'advanced-developer', 'automated-system-testing.md', 'Automated System Testing', '2023-02-12 09:20:52') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Core_APIs', 'developer', 'en', 'advanced-developer', 'joomla-core-apis.md', 'Joomla Core APIs', '2023-02-12 09:20:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:SCSS_and_Sass', 'developer', 'en', 'advanced-developer', 'scss-and-sass.md', 'SCSS and Sass', '2023-02-12 09:20:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Http_Header_Management', 'developer', 'en', 'advanced-administrator', 'http-header-management.md', 'Http Header Management', '2023-02-12 09:21:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Improved_Override_Management', 'developer', 'en', 'advanced-administrator', 'improved-override-management.md', 'Improved Override Management', '2023-02-12 09:21:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Entities', 'developer', 'en', 'unclassified', 'joomla-entities.md', 'Joomla Entities', '2023-02-12 09:21:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Changed_parameters_for_template_providers', 'developer', 'en', 'unclassified', 'changed-parameters-for-template-providers.md', 'Changed parameters for template providers', '2023-02-12 09:21:08') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:ClientSideEvents', 'developer', 'en', 'unclassified', 'clientsideevents.md', 'ClientSideEvents', '2023-02-12 09:21:11') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Page_Builder', 'developer', 'en', 'unclassified', 'page-builder.md', 'Page Builder', '2023-02-12 09:21:14') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Response_Formats', 'developer', 'en', 'unclassified', 'response-formats.md', 'Response Formats', '2023-02-12 09:21:17') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('XAMPP', 'developer', 'de', 'getting-started', 'xampp.md', 'XAMPP', '2023-02-11 14:38:23') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Setting_Up_Your_Local_Environment', 'developer', 'de', 'developer-information', 'setting-up-your-local-environment.md', 'Joomla! an die eigene Umgebung anpassen', '2023-02-11 14:38:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Working_with_git_and_github', 'developer', 'de', 'developer-information', 'working-with-git-and-github.md', 'Mit Git und GitHub arbeiten', '2023-02-11 14:38:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Manifest_files', 'developer', 'de', 'developer-information', 'manifest-files.md', 'Manifest-Dateien', '2023-02-11 14:38:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Namespace_Conventions_In_Joomla', 'developer', 'de', 'developer-information', 'namespace-conventions-in-joomla.md', 'Namensraum-Konventionen in Joomla', '2023-02-11 14:38:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Web_Assets', 'developer', 'de', 'developer-information', 'web-assets.md', 'Web-Assets', '2023-02-11 14:38:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Dependency_Injection_in_Joomla_4', 'developer', 'de', 'developer-information', 'dependency-injection-in-joomla-4.md', 'Dependency Injection in Joomla 4', '2023-02-11 14:38:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Core_APIs', 'developer', 'de', 'developer-information', 'joomla-core-apis.md', 'Joomla Kern-API´s', '2023-02-11 14:38:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Deploying_an_Update_Server', 'developer', 'de', 'developer-information', 'deploying-an-update-server.md', ' Einen Update-Server bereitstellen', '2023-02-11 14:38:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_a_Plugin_for_Joomla', 'developer', 'de', 'plugin-development', 'creating-a-plugin-for-joomla.md', 'Ein Plugin für Joomla! erstellen', '2023-02-11 14:38:54') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Creating_a_Smart_Search_plug-in', 'developer', 'de', 'plugin-development', 'creating-a-smart-search-plug-in.md', 'Smart Search-Plugin anlegen', '2023-02-11 14:38:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Triggering_content_plugins_in_your_extension', 'developer', 'de', 'plugin-development', 'triggering-content-plugins-in-your-extension.md', 'Inhaltsplugins in eigenen Erweiterungen auslösen', '2023-02-11 14:38:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Cloud_File_Systems_for_Media_Manager', 'developer', 'de', 'plugin-development', 'cloud-file-systems-for-media-manager.md', 'Cloud-Dateisysteme für den Medien-Manager', '2023-02-11 14:39:01') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_a_Simple_Module', 'developer', 'de', 'module-development', 'creating-a-simple-module.md', 'Ein einfaches Modul erstellen', '2023-02-11 14:39:06') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component', 'developer', 'de', 'developing-an-mvc-component', 'developing-an-mvc-component.md', 'Entwicklung einer MVC Komponente', '2023-02-11 14:39:09') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component/Setting_up_the_Database', 'developer', 'de', 'developing-an-mvc-component', 'developing-an-mvc-component-setting-up-the-database.md', 'Entwickeln einer MVC-Komponente/Einrichten der Datenbank', '2023-02-11 14:39:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_an_API_to_a_Joomla_Component', 'developer', 'de', 'developing-an-mvc-component', 'adding-an-api-to-a-joomla-component.md', 'Eine API zu einer Joomla-Komponente hinzufügen', '2023-02-11 14:39:20') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Writing_A_CLI_Application', 'developer', 'de', 'cli-development', 'writing-a-cli-application.md', 'Eine CLI-Anwendung erstellen', '2023-02-11 14:39:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:CLI_Database_Exporter_Importer', 'developer', 'de', 'cli-development', 'cli-database-exporter-importer.md', ' CLI Datenbank Export / Import', '2023-02-11 14:39:33') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:CLI_Update', 'developer', 'de', 'cli-development', 'cli-update.md', 'CLI Update', '2023-02-11 14:39:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Moving_Joomla_To_Prepared_Statements', 'developer', 'de', 'database', 'moving-joomla-to-prepared-statements.md', 'Umstellung in Joomla auf Prepared Statements', '2023-02-11 14:39:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Selecting_data_using_JDatabase', 'developer', 'de', 'database', 'selecting-data-using-jdatabase.md', ' Nutzung von JDatabase für Datenabfragen', '2023-02-11 14:39:41') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Inserting_Updating_and_Removing_data_using_JDatabase', 'developer', 'de', 'database', 'inserting-updating-and-removing-data-using-jdatabase.md', ' Einfügen, aktualisieren und löschen von Daten unter Verwendung von JDatabase', '2023-02-11 14:39:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Core_APIs', 'developer', 'de', 'advanced-developer', 'joomla-core-apis.md', 'Joomla Kern-API´s', '2023-02-11 14:39:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:SCSS_and_Sass', 'developer', 'de', 'advanced-developer', 'scss-and-sass.md', 'SCSS und Sass', '2023-02-11 14:39:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Http_Header_Management', 'developer', 'de', 'advanced-administrator', 'http-header-management.md', 'HTTP Header Verwaltung', '2023-02-11 14:39:53') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Improved_Override_Management', 'developer', 'de', 'advanced-administrator', 'improved-override-management.md', 'Verbesserte Overrideverwaltung', '2023-02-11 14:39:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Entities', 'developer', 'de', 'unclassified', 'joomla-entities.md', 'Joomla Entities', '2023-02-11 14:39:58') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Page_Builder', 'developer', 'de', 'unclassified', 'page-builder.md', 'Page Builder', '2023-02-11 14:40:02') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('XAMPP', 'developer', 'fr', 'getting-started', 'xampp.md', 'XAMPP', '2023-02-11 14:40:18') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Setting_Up_Your_Local_Environment', 'developer', 'fr', 'developer-information', 'setting-up-your-local-environment.md', 'Paramétrer votre environnement local', '2023-02-11 14:40:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Working_with_git_and_github', 'developer', 'fr', 'developer-information', 'working-with-git-and-github.md', 'Travailler avec Git et GitHub', '2023-02-11 14:40:26') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Manifest_files', 'developer', 'fr', 'developer-information', 'manifest-files.md', 'Fichiers manifest', '2023-02-11 14:40:29') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Namespace_Conventions_In_Joomla', 'developer', 'fr', 'developer-information', 'namespace-conventions-in-joomla.md', 'Conventions d''espace de nommage dans Joomla', '2023-02-11 14:40:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Web_Assets', 'developer', 'fr', 'developer-information', 'web-assets.md', 'Ressources web (Web Assets)', '2023-02-11 14:40:34') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Dependency_Injection_in_Joomla_4', 'developer', 'fr', 'developer-information', 'dependency-injection-in-joomla-4.md', 'Injection de dépendances dans Joomla 4', '2023-02-11 14:40:37') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Core_APIs', 'developer', 'fr', 'developer-information', 'joomla-core-apis.md', 'Joomla - API natives', '2023-02-11 14:40:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Deploying_an_Update_Server', 'developer', 'fr', 'developer-information', 'deploying-an-update-server.md', 'Le déploiement d''un serveur de mise à jour', '2023-02-11 14:40:43') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_CodeSniffer', 'developer', 'fr', 'developer-information', 'joomla-codesniffer.md', 'Joomla CodeSniffer ''Renifleur de Code''', '2023-02-11 14:40:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_a_Plugin_for_Joomla', 'developer', 'fr', 'plugin-development', 'creating-a-plugin-for-joomla.md', 'Créer un plugin pour Joomla', '2023-02-11 14:40:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Triggering_content_plugins_in_your_extension', 'developer', 'fr', 'plugin-development', 'triggering-content-plugins-in-your-extension.md', 'Déclenchement des plugins de contenu dans votre extension', '2023-02-11 14:40:51') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_a_Simple_Module', 'developer', 'fr', 'module-development', 'creating-a-simple-module.md', 'Création d''un module simple', '2023-02-11 14:40:56') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component', 'developer', 'fr', 'developing-an-mvc-component', 'developing-an-mvc-component.md', 'Développement d''un composant MVC', '2023-02-11 14:40:59') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Developing_an_MVC_Component/Language_Management', 'developer', 'fr', 'developing-an-mvc-component', 'developing-an-mvc-component-language-management.md', 'Développement d''un composant MVC - Ajout d''un gestionnaire de langues', '2023-02-11 14:41:05') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Adding_an_API_to_a_Joomla_Component', 'developer', 'fr', 'developing-an-mvc-component', 'adding-an-api-to-a-joomla-component.md', 'Ajout d''une API à un composant de Joomla', '2023-02-11 14:41:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:CLI_Database_Exporter_Importer', 'developer', 'fr', 'cli-development', 'cli-database-exporter-importer.md', 'CLI Exportateur / Importateur de base de données', '2023-02-11 14:41:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:CLI_Update', 'developer', 'fr', 'cli-development', 'cli-update.md', 'Mise à jour CLI (lignes de commande)', '2023-02-11 14:41:24') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Selecting_data_using_JDatabase', 'developer', 'fr', 'database', 'selecting-data-using-jdatabase.md', 'Sélection de données avec JDatabase', '2023-02-11 14:41:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Inserting_Updating_and_Removing_data_using_JDatabase', 'developer', 'fr', 'database', 'inserting-updating-and-removing-data-using-jdatabase.md', 'Insertion, mise à Jour et suppression de données à l''aide de JDatabase', '2023-02-11 14:41:30') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Core_APIs', 'developer', 'fr', 'advanced-developer', 'joomla-core-apis.md', 'Joomla - API natives', '2023-02-11 14:41:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:SCSS_and_Sass', 'developer', 'fr', 'advanced-developer', 'scss-and-sass.md', 'SCSS et Sass', '2023-02-11 14:41:38') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Http_Header_Management', 'developer', 'fr', 'advanced-administrator', 'http-header-management.md', 'Gestion des En-têtes HTTP', '2023-02-11 14:41:40') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Improved_Override_Management', 'developer', 'fr', 'advanced-administrator', 'improved-override-management.md', 'Gestion améliorée des substitutions', '2023-02-11 14:41:42') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Entities', 'developer', 'fr', 'unclassified', 'joomla-entities.md', 'Joomla Entities', '2023-02-11 14:41:45') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Page_Builder', 'developer', 'fr', 'unclassified', 'page-builder.md', 'Constructeur de page', '2023-02-11 14:41:50') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('XAMPP', 'developer', 'nl', 'getting-started', 'xampp.md', 'XAMPP', '2023-02-11 14:44:49') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Setting_Up_Your_Local_Environment', 'developer', 'nl', 'developer-information', 'setting-up-your-local-environment.md', 'Je lokale omgeving opzetten', '2023-02-11 14:44:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Working_with_git_and_github', 'developer', 'nl', 'developer-information', 'working-with-git-and-github.md', 'Werken met git en github', '2023-02-11 14:44:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Manifest_files', 'developer', 'nl', 'developer-information', 'manifest-files.md', 'Manifest bestanden', '2023-02-11 14:45:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Web_Assets', 'developer', 'nl', 'developer-information', 'web-assets.md', 'Web assets', '2023-02-11 14:45:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Dependency_Injection_in_Joomla_4', 'developer', 'nl', 'developer-information', 'dependency-injection-in-joomla-4.md', 'Dependency Injection in Joomla 4', '2023-02-11 14:45:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Core_APIs', 'developer', 'nl', 'developer-information', 'joomla-core-apis.md', 'Joomla - Core APIs', '2023-02-11 14:45:10') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_a_Plugin_for_Joomla', 'developer', 'nl', 'plugin-development', 'creating-a-plugin-for-joomla.md', 'Een plugin bouwen voor Joomla!', '2023-02-11 14:45:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Cloud_File_Systems_for_Media_Manager', 'developer', 'nl', 'plugin-development', 'cloud-file-systems-for-media-manager.md', 'Cloud Bestands Systems voor Media Beheer', '2023-02-11 14:45:21') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_a_Simple_Module', 'developer', 'nl', 'module-development', 'creating-a-simple-module.md', 'Een eenvoudige module maken', '2023-02-11 14:45:25') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:CLI_Database_Exporter_Importer', 'developer', 'nl', 'cli-development', 'cli-database-exporter-importer.md', 'CLI Database Exporter Importer', '2023-02-11 14:45:48') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Joomla_Core_APIs', 'developer', 'nl', 'advanced-developer', 'joomla-core-apis.md', 'Joomla - Core APIs', '2023-02-11 14:45:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:SCSS_and_Sass', 'developer', 'nl', 'advanced-developer', 'scss-and-sass.md', 'SCSS en Sass', '2023-02-11 14:46:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Http_Header_Management', 'developer', 'nl', 'advanced-administrator', 'http-header-management.md', 'Http header beheer', '2023-02-11 14:46:02') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Improved_Override_Management', 'developer', 'nl', 'advanced-administrator', 'improved-override-management.md', 'Verbeterd Override management', '2023-02-11 14:46:04') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Page_Builder', 'developer', 'nl', 'unclassified', 'page-builder.md', 'Page Builder', '2023-02-11 14:46:09') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('XAMPP', 'developer', 'pt-br', 'getting-started', 'xampp.md', 'XAMPP', '2023-02-11 14:47:50') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Setting_Up_Your_Local_Environment', 'developer', 'pt-br', 'developer-information', 'setting-up-your-local-environment.md', 'Configurando seu ambiente local', '2023-02-11 14:47:55') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Working_with_git_and_github', 'developer', 'pt-br', 'developer-information', 'working-with-git-and-github.md', 'Trabalhando com git e github', '2023-02-11 14:47:57') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_a_Plugin_for_Joomla', 'developer', 'pt-br', 'plugin-development', 'creating-a-plugin-for-joomla.md', 'Criando um plugin para o Joomla', '2023-02-11 14:48:07') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:CLI_Database_Exporter_Importer', 'developer', 'pt-br', 'cli-development', 'cli-database-exporter-importer.md', 'Exportador e importador de banco de dados de interface de linha de comando (CLI)', '2023-02-11 14:48:35') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Moving_Joomla_To_Prepared_Statements', 'developer', 'pt-br', 'database', 'moving-joomla-to-prepared-statements.md', 'Movendo o Joomla para instruções preparadas', '2023-02-11 14:48:39') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_a_Simple_Module', 'developer', 'pt', 'module-development', 'creating-a-simple-module.md', 'Criação de Módulo Simples', '2023-02-11 14:46:44') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Working_with_git_and_github', 'developer', 'ru', 'developer-information', 'working-with-git-and-github.md', 'Работа с git и github', '2023-02-11 14:49:16') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Web_Assets', 'developer', 'ru', 'developer-information', 'web-assets.md', 'Web Assets', '2023-02-11 14:49:22') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Joomla_CodeSniffer', 'developer', 'ru', 'developer-information', 'joomla-codesniffer.md', 'Joomla CodeSniffer', '2023-02-11 14:49:28') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_a_Plugin_for_Joomla', 'developer', 'ru', 'plugin-development', 'creating-a-plugin-for-joomla.md', 'Создание Плагина для Joomla', '2023-02-11 14:49:31') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Creating_a_Simple_Module', 'developer', 'ru', 'module-development', 'creating-a-simple-module.md', 'Creating a Simple Module', '2023-02-11 14:49:38') ON DUPLICATE KEY UPDATE id = id;

INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('J4.x:Fix_Database_Table_Structure_NOT_Up_to_Date_before_Update', 'user', 'en', 'problems', 'fix-database-table-structure-not-up-to-date-before-update.md', 'Fix \"Database Table Structure NOT Up To Date\" Before Update', '2023-03-29 12:00:00') ON DUPLICATE KEY UPDATE id = id;


INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Admin_Modules:_Tours_Menu', 'help', 'en', 'admin-modules', 'admin-modules-guided-tours.md', 'Admin Modules: Tours Menu', '2023-03-29 12:00:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Guided_Tours:_New_or_Edit_Step', 'help', 'en', 'guided-tours', 'guided-tours-new-or-edit-step.md', 'Guided Tours: New or Edit Step', '2023-03-29 12:00:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Guided_Tours:_New_or_Edit_Tour', 'help', 'en', 'guided-tours', 'guided-tours-new-or-edit-tour.md', 'Guided Tours: New or Edit Tour', '2023-03-29 12:00:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Guided_Tours:_Options', 'help', 'en', 'guided-tours', 'guided-tours-options.md', 'Guided Tours: Options', '2023-03-29 12:00:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Guided_Tours:_Steps', 'help', 'en', 'guided-tours', 'guided-tours-steps.md', 'Guided Tours: Steps', '2023-03-29 12:00:00') ON DUPLICATE KEY UPDATE id = id;
INSERT INTO `#__jdocmanual_gfmindex` (`jdoc_key`, `manual`, `language`, `heading`, `filename`, `display_title`, `created`) VALUES
	('Help4.x:Guided_Tours:_Tours', 'help', 'en', 'guided-tours', 'guided-tours-tours.md', 'Guided Tours: Tours', '2023-03-29 12:00:00') ON DUPLICATE KEY UPDATE id = id;

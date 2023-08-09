<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Field;

use Joomla\CMS\Form\Field\ListField;
use Joomla\CMS\Language\Text;
use Joomla\Database\ParameterType;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * For a new record return a datalist field.
 * For an existing record return a text field.
 */
class HeadingField extends ListField {

	protected $type = 'Heading';

	public function getInput()
	{
		$id = $this->form->getValue('id');

		// For a new article stash the id is not set.
		if (empty($this->form->getValue('page_id')) && empty($this->form->getValue('id'))) {
            // Use a datalist element.
            $html = '<div class="controls">';
            $html .= '<input list="headings" name="jform[heading]" id="jform_heading" ';
            $html .= 'class="form-control required" required="" autocomplete="off" placeholder="';
            $html .= Text::_('COM_JDOCMANUAL_ARTICLE_STASH_HEADING_PLACEHOLDER')  . '"/> ';

            // Get the list of headings for this manual.
            $manual = $this->form->getValue('manual');
            $db = $this->getDatabase();
            $query = $db->getQuery(true);
            $query->select('*')
            ->from($db->quoteName('#__jdm_menu_headings'))
            ->where($db->quoteName('manual') . ' = :manual')
            ->where($db->quoteName('language') . ' = ' . $db->quote('en'))
            ->order($db->quoteName('heading') . 'ASC')
            ->bind(':manual', $manual, ParameterType::STRING);
            $db->setQuery($query);
            $test = $query->__tostring();
            $rows = $db->loadObjectList();

            $html .= '<datalist id="headings">';

            foreach ($rows as $row) {
                $html .= '<option value="' . $row->heading . '"></option>';
            }

            $html .= '</datalist>';
            $html .= '</div>';
        } else {
            // Use a text element.
            $html = '<div class="controls">';
            $html .= '<input type="text" name="jform[heading]" id="jform_heading" ';
            $html .= 'value="' . $this->form->getValue('heading') . '" class="form-control readonly required" ';
            $html .= 'readonly="" required="">';
            $html .= '</div>';
        }

        return $html;
    }
}

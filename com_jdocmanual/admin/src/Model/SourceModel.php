<?php
/**
 * @package     Jdocmanual.Administrator
 * @subpackage  com_jdocmanual
 *
 * @copyright   (C) 2021 Clifford E Ford
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Model;

defined('_JEXEC') or die;

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\Filesystem\File;
use Joomla\CMS\Form\Form;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\Model\AdminModel;
use Joomla\CMS\Table\Table;
use Joomla\Database\ParameterType;

/**
 * Item Model for a single source.
 *
 * @since  1.6
 */

class SourceModel extends AdminModel
{
	/**
	 * The prefix to use with controller messages.
	 *
	 * @var    string
	 * @since  1.6
	 */
	protected $text_prefix = 'COM_JDOCMANUAL';

	/**
	 * Method to test whether a record can be deleted.
	 *
	 * @param   object  $record  A record object.
	 *
	 * @return  boolean  True if allowed to delete the record. Defaults to the permission set in the component.
	 *
	 * @since   1.6
	 */
	protected function canDelete($record)
	{
		if (!empty($record->id))
		{
			return Factory::getUser()->authorise('core.delete', 'com_jdocmanual.source.' . (int) $record->id);
		}

		return false;
	}

	/**
	 * Method to test whether a record can have its state edited.
	 *
	 * @param   object  $record  A record object.
	 *
	 * @return  boolean  True if allowed to change the state of the record. Defaults to the permission set in the component.
	 *
	 * @since   1.6
	 */
	protected function canEditState($record)
	{
		$user = Factory::getUser();

		// Check for existing article.
		if (!empty($record->id))
		{
			return $user->authorise('core.edit.state', 'com_jdocmanual.source.' . (int) $record->id);
		}

		// Default to component settings if neither article nor category known.
		return parent::canEditState($record);
	}

	/**
	 * Method to get the record form.
	 *
	 * @param   array    $data      Data for the form.
	 * @param   boolean  $loadData  True if the form is to load its own data (default case), false if not.
	 *
	 * @return  Form|boolean  A Form object on success, false on failure
	 *
	 * @since   1.6
	 */
	public function getForm($data = array(), $loadData = true)
	{
		// Get the form.
		$form = $this->loadForm('com_jdocmanual.source', 'source', array('control' => 'jform', 'load_data' => $loadData));

		if (empty($form))
		{
			return false;
		}

		return $form;
	}
	/**
	 * Method to get a single record.
	 *
	 * @param   integer  $pk  The id of the primary key.
	 *
	 * @return  mixed  Object on success, false on failure.
	 */
	public function getItem($pk = null)
	{
		return parent::getItem($pk);
	}

	/**
	 * Method to get the data that should be injected in the form.
	 *
	 * @return  mixed  The data for the form.
	 *
	 * @since   1.6
	 */
	protected function loadFormData()
	{
		// Check the session for previously entered form data.
		$app = Factory::getApplication();
		$data = $app->getUserState('com_jdocmanual.edit.source.data', array());

		if (empty($data))
		{
			$data = $this->getItem();

			// Pre-select some filters (Status, Category, Language, Access) in edit form if those have been selected in Article Manager: Articles
		}

		return $data;
	}

	/**
	 * Method to change the published state of one or more records.
	 *
	 * @param   array    &$pks   A list of the primary keys to change.
	 * @param   integer  $value  The value of the published state.
	 *
	 * @return  boolean  True on success.
	 *
	 * @since   4.0.0
	 */
	public function publish(&$pks, $value = 1)
	{
		/* this is a very simple method to change the state of each item selected */
		$db = $this->getDbo();

		$query = $db->getQuery(true);

		$query->update($db->quoteName('#__jdocmanual_sources'))
		->set($db->quoteName('state') . ' = :value');
		$query->whereIn($db->quoteName('id') , $pks)
		->bind(':value', $value, ParameterType::INTEGER);
		$db->setQuery($query);
		$db->execute();
	}
	/**
	 * Method to save the form data.
	 *
	 * @param   array  $data  The form data.
	 *
	 * @return  boolean  True on success.
	 *
	 * @since   1.6
	 */
	public function save($data)
	{
		$tmp = implode(',', (array) $data['categories']);
		$data['categories'] = $tmp;
		return parent::save($data);
	}
}
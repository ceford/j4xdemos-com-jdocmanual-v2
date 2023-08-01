<?php

/**
 * @package     Jdocmanual
 * @subpackage  Administrator
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\View\Language;

use Joomla\CMS\Component\ComponentHelper;
use Joomla\CMS\Factory;
use Joomla\CMS\Helper\ContentHelper;
use Joomla\CMS\Language\Associations;
use Joomla\CMS\Language\Text;
use Joomla\CMS\MVC\View\GenericDataException;
use Joomla\CMS\MVC\View\HtmlView as BaseHtmlView;
use Joomla\CMS\Toolbar\ToolbarHelper;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * View to edit a language.
 *
 * @since  1.6
 */
class HtmlView extends BaseHtmlView
{
    /**
     * The \JForm object
     *
     * @var  \JForm
     */
    protected $form;

    /**
     * The active item
     *
     * @var  object
     */
    protected $item;

    /**
     * The model state
     *
     * @var  \JObject
     */
    protected $state;

    /**
     * Display the view.
     *
     * @param   string  $tpl  The name of the template file to parse; automatically searches through the template paths.
     *
     * @return  mixed  A string if successful, otherwise an Error object.
     */
    public function display($tpl = null)
    {
        // Initialise variables.
        $this->form  = $this->get('Form');
        $this->item  = $this->get('Item');
        $this->state = $this->get('State');

        // Check for errors.
        if (count($errors = $this->get('Errors'))) {
            throw new GenericDataException(implode("\n", $errors), 500);
        }

        $this->addToolbar();

        return parent::display($tpl);
    }

    /**
     * Add the page title and toolbar.
     *
     * @return  void
     *
     * @since   1.6
     */
    protected function addToolbar()
    {
        $tmpl = Factory::getApplication()->input->getCmd('tmpl');

        Factory::getApplication()->input->set('hidemainmenu', true);

        $user       = Factory::getUser();
        $userId     = $user->id;
        $isNew      = ($this->item->id == 0);

        ToolbarHelper::title(
            $isNew ? Text::_('COM_JDOCMANUAL_LANGUAGE_NEW') : Text::_('COM_JDOCMANUAL_LANGUAGE_EDIT'),
            'language jdocmanual'
        );

        ToolbarHelper::apply('language.apply');
        ToolbarHelper::save('language.save');

        if (empty($isNew)) {
            ToolbarHelper::cancel('language.cancel', 'JTOOLBAR_CLOSE');
        } else {
            ToolbarHelper::cancel('language.cancel');
        }

        ToolbarHelper::divider();

        if ($tmpl !== 'component') {
            ToolbarHelper::help('language', true);
        }
    }
}

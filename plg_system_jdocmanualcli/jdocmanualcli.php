<?php

/**
 * @package     Jdocmanual
 * @subpackage  Plugin
 *
 * @copyright   (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 *
 * @phpcs:disable PSR1.Classes.ClassDeclaration.MissingNamespace
 */

use Joomla\CMS\Plugin\CMSPlugin;
use Joomla\CMS\Factory;
use Joomla\Event\SubscriberInterface;
use J4xdemos\Component\Jdocmanual\Administrator\Cli\JdocmanualCommand;

// phpcs:disable PSR1.Files.SideEffects
\defined('_JEXEC') or die;
// phpcs:enable PSR1.Files.SideEffects

/**
 * System plugin to add command line functionality for Jdocmanual.
 *
 * @since  1.0
 */
class PlgSystemJdocmanualcli extends CMSPlugin implements SubscriberInterface
{
    /**
     * Returns the event this subscriber will listen to.
     *
     * @return  array
     *
     * @since   4.0.0
     */
    public static function getSubscribedEvents(): array
    {
        return [
                \Joomla\Application\ApplicationEvents::BEFORE_EXECUTE => 'registerCommands',
        ];
    }

    /**
     * Returns the command class for the Jdocmanual CLI plugin.
     *
     * @return  void
     *
     * @since   4.0.0
     */
    public function registerCommands(): void
    {
        $serviceId = 'jdocmanual.action';

        Factory::getContainer()->share(
            $serviceId,
            function (\Psr\Container\ContainerInterface $container) {
                // Do stuff to create command class and return it
                return new JdocmanualCommand();
            },
            true
        );

        Factory::getContainer()
        ->get(\Joomla\CMS\Console\Loader\WritableLoaderInterface::class)
        ->add('jdocmanual:action', $serviceId);
    }
}

<?php

/**
 * @package     Jdocmanual.Cli
 * @copyright   Copyright (C) 2023 Clifford E Ford. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

namespace J4xdemos\Component\Jdocmanual\Administrator\Cli;

use Joomla\Console\Command\AbstractCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Question\ChoiceQuestion;
use Symfony\Component\Console\Style\SymfonyStyle;
use J4xdemos\Component\Jdocmanual\Administrator\Cli\Buildarticles;
use J4xdemos\Component\Jdocmanual\Administrator\Cli\Buildmenus;
use J4xdemos\Component\Jdocmanual\Administrator\Cli\Buildproxy;
use J4xdemos\Component\Jdocmanual\Administrator\Cli\Checkhistory;

// phpcs:disable PSR1.Files.SideEffects
\defined('JPATH_PLATFORM') or die;
// phpcs:enable PSR1.Files.SideEffects

class JdocmanualCommand extends AbstractCommand
{
    /**
     * The default command name
     *
     * @var    string
     * @since  4.0.0
     */
    protected static $defaultName = 'jdocmanual:action';

    /**
     * @var InputInterface
     * @since version
     */
    private $cliInput;

    /**
     * SymfonyStyle Object
     * @var SymfonyStyle
     * @since 4.0.0
     */
    private $ioStyle;

    /**
     * Configures the IO
     *
     * @param   InputInterface   $input   Console Input
     * @param   OutputInterface  $output  Console Output
     *
     * @return void
     *
     * @since 4.0.0
     *
     */
    private function configureIO(InputInterface $input, OutputInterface $output)
    {
        $this->cliInput = $input;
        $this->ioStyle = new SymfonyStyle($input, $output);
    }

    /**
     * Initialise the command.
     *
     * @return  void
     *
     * @since   4.0.0
     */
    protected function configure(): void
    {
        $this->addArgument(
            'action',
            InputArgument::REQUIRED,
            'name of action'
        );
        $help = "<info>%command.name%</info> Runs Jdocmanual action jobs
				\nUsage: <info>php %command.full_name% action (one of buildarticles buildmenus, buildproxy or checkhistory)</info>";
        $this->addArgument(
            'manual',
            InputArgument::REQUIRED,
            'one of developer, help or user'
        );
        $this->addArgument(
            'language',
            InputArgument::REQUIRED,
            'two letter code, example: de'
        );

        $this->setDescription('Called on command line or by cron to run Jdocmanual action jobs.');
        $this->setHelp($help);
    }

    /**
     * Internal function to execute the command.
     *
     * @param   InputInterface   $input   The input to inject into the command.
     * @param   OutputInterface  $output  The output to inject into the command.
     *
     * @return  integer  The command exit code
     *
     * @since   4.0.0
     */
    protected function doExecute(InputInterface $input, OutputInterface $output): int
    {
        $this->configureIO($input, $output);

        $action = $this->cliInput->getArgument('action');
        $manual = $this->cliInput->getArgument('manual');
        $language = $this->cliInput->getArgument('language');

        switch ($action) {
            case 'buildarticles':
                $buildarticles = new Buildarticles();
                $result = $buildarticles->go($manual, $language);
                break;
            case 'buildmenus':
                $buildmenus = new Buildmenus();
                $result = $buildmenus->go($manual, $language);
                break;
            case 'buildproxy':
                $buildproxy = new Buildproxy();
                $result = $buildproxy->go($manual, $language);
                break;
            case 'buildproxy':
                $buildproxy = new Buildproxy();
                $result = $buildproxy->go($manual, $language);
                break;
            case 'checkhistory':
                $checkhistory = new Checkhistory();
                $result = $checkhistory->go($manual, $language);
                break;
            default:
                $this->ioStyle->error("Unknwon action: {$action}");
                return 0;
        }
        $this->ioStyle->success("That seemed to work: {$action}");
        echo $result;

        return 1;
    }
}

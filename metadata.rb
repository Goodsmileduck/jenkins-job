name             'jenkins-job'
maintainer       'Stas Serebrennikov'
maintainer_email ''
license          'All rights reserved'
description      'Installs/Configures jenkins with JJB and job-plugin'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends 'jenkins'
depends 'python'
depends 'yum'
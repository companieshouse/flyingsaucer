Flying Saucer
=====================
http://code.google.com/p/flying-saucer/
Please see project website for links to git, mailing lists, issue tracker, etc.

RELEASES
--------
Our forked repo had 2 releases and they were tagged as (`v1.0.0-rc1` and `v1.0.0-rc2`) until the service was built in Jenkins.
The original repo instead had releases tagged as `9.x.x`, with [9.2.21](https://github.com/flyingsaucerproject/flyingsaucer/releases/tag/v9.1.21) being the last one at the time we started migrating the build from Jenkins to Concourse.
In Concourse we started naming the releases as `10.x.x` and `11.x.x` until the pipeline proved to be stable.
The first official stable release was then tagged as `12.0.0` and `10.x.x` and `11.x.x` were left as the intermediate attempts.

OVERVIEW
--------
Flying Saucer is a pure-Java library for rendering arbitrary well-formed XML
(or XHTML) using CSS 2.1 for layout and formatting, output to Swing panels,
PDF, and images.

Comprehensive documentation available in our user's guide, linked from our website at http://code.google.com/p/flying-saucer/
For information on our development releases, please contact us on our mailing lists.

If you end up using Flying Saucer for your own projects, please drop us an
email and tell us about it; it helps inform where we go next, and is interesting
and inspiring to other developers.


LICENSE
-------
Flying Saucer is distributed under the LGPL.  Flying Saucer itself is licensed
under the GNU Lesser General Public License, version 2.1 or later, available at
http://www.gnu.org/copyleft/lesser.html. You can use Flying Saucer in any
way and for any purpose you want as long as you respect the terms of the
license. A copy of the LGPL license is included as license-lgpl-2.1.txt or license-lgpl-3.txt
in our distributions and in our source tree.

Flying Saucer uses a couple of FOSS packages to get the job done. A list
of these, along with the license they each have, is listed in the
LICENSE file in our distribution.

GETTING FLYING SAUCER
---------------------
New releases of Flying Saucer are distributed through Maven.  The available artifacts are:

org.xhtmlrenderer:flying-saucer-core - Core library and Java2D rendering
org.xhtmlrenderer:flying-saucer-pdf - PDF output using iText
org.xhtmlrenderer:flying-saucer-swt - SWT output
org.xhtmlrenderer:flying-saucer-log4j - Logging plugin for log4j

GETTING STARTED
---------------
There is a large amount of sample code under the flying-saucer-demos directory.
A pre-configured Eclipse project is provided to run a few of them.

For users of other IDEs, make sure the src/java and resources directories under
the about, docbook, svg, and browser directories are available on the build
path.  samples/src and splash should also be in the build path.

flying-saucer-core, flying-saucer-pdf, and flying-saucer-swt must also be on the
build path as well as the an SWT JAR for your OS.

The Eclipse config files as committed with flying-saucer-swt use a Linux SWT
JAR.  You will need to update if using another OS.

org.xhtmlrenderer.demo.browser.BrowserStartup will start the browser demo.

Some good entry points (classes) are:
org.xhtmlrenderer.simple.XHTMLPanel
org.xhtmlrenderer.simple.PDFRenderer
org.xhtmlrenderer.simple.ImageRenderer


PDF/A Conformance
---------------
PDF/A conformance is an ISO-standardized version of the PDF for long term preservation of electronic documents.

PDF/A conformance can be set using:
```
ITextRenderer renderer = new ITextRenderer();
renderer.setPDFXConformance(PdfWriter.PDFA1A);
```

The colour profile needs to be set to be used for the output intents for the output device.
```
ITextRenderer renderer = new ITextRenderer();
renderer.setColourSpaceProfile(path);
```

The fonts need to be embedded into the PDF:
```
ITextRenderer renderer = new ITextRenderer();
ITextFontResolver fontResolver = renderer.getFontResolver();
fontResolver.addFont(path, name, BaseFont.IDENTITY_H, BaseFont.EMBEDDED, null);
```

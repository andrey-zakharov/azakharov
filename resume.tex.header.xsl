<?xml version="1.0"?>
<stylesheet
        xmlns:xlink="http://www.w3.org/1999/xlink"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.w3.org/1999/XSL/Transform"
        version="1.0">

    <template match = "/">\input{predoc.tex}%
        <apply-templates select = '/Document/Meta' />
        \begin{document}
        \makecvtitle%
        \cloud%
        <apply-templates select = '/Document/Meta/following-sibling::*[not(@lang) or @lang=$lang]' />
        \end{document}
    </template>

</stylesheet>

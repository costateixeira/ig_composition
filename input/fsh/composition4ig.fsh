/*
Notes:
Composition can become the intermediate format for customizing artifact index, menus and page content.
The existing behaviour can still be expressed in Compositions (i.e. the template can generate a Composition and then take it from there)
Pages can be transformed into markdown/Annotation (data type) or Narrative (resource type)
Three things can be in a composition: Artifact groups, menus and page structure

There are 2 options:
 - One composition for menus + pages + artifacts, 
 - One composition of a given type for each? This example below assumes this option  - remarks are given about differences if it were one Composition.

The use of section.text may not be a good idea so it can change

*/

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
//// Composition 1: The Artifact Index
////////////////////////////////////////////////////////////////////////////

Instance: IGArtifacts 
InstanceOf: Composition
Usage: #example
Description: "IG Artifact Composition"
Title:   "IG Artifact Composition"

* status = #final
* type = #ig-artifacts // this one is for artifacts list. If this type of composition is not available, we take the default behaviour (e.g. the system creates one). The Composition represents the entire Artifacts page. If several are available, several artifacts pages will be created (?)
// * subject = Reference (myIG) // TBD later: do we need this?
* date = "2021-01-01"
* author.identifier.value = "IHE Belgium"
* title = "Artifacts Index"
// one advantage of having one single Composition is that this would be one level lower and could have a .text here (introductory text at the top of the artifact index page)
// since this is type=#ig-artifacts, this corresponde to a page, Sub-sections would be tabs in that page, for example.

// The equivalent to today's behaviour would be to only have one top section i.e. having only one "artifact-section" here (or to suppress it altogether? Would the template know?)
* section[0].title = "Artifacts - By Type" 
* section[0].text.div = "<div><p>Artifact index by type</p></div>" // or resource description
* section[0].text.status = #additional
* section[0].mode = #artifact-section 

// Each L2 section is an artifact group 
// Each L2 section contains artifacts
// The equivalent to today's behaviour would be to add the same sections here as the default grouping in the IG templates

* section[0].section[0].title = "Profiles" // Same as grouping names titles
* section[0].section[0].text.div = "<div><p>Some intro about Profiles</p></div>" // Same as grouping descriptions
* section[0].section[0].text.status = #additional
* section[0].mode = #artifact-page // # menu // #menu-entry // #resource // #page

// each entry in the grouping list
* section[0].section[0].entry[0] = Reference(Profile1)
* section[0].section[0].entry[0].display = "Profile 1"

// Under each artifact we can have the example instances (if examples are of certain types?)
* section[0].section[0].section[0].focus = Reference(Profile1)
* section[0].section[0].section[0].entry[0] = Reference(OneExampleForProfile1)
* section[0].section[0].section[0].entry[0].display = "This instance is an example of Profile 1"
* section[0].section[0].section[0].entry[1] = Reference(AnotherExampleForProfile1)
* section[0].section[0].section[0].entry[1].display = "This instance is another example of Profile 1"

// TBD: What to do with instances that are not of the profiles of the IG?


// More artifacts - profiles and extension
* section[0].section[0].entry[1] = Reference(Profile2)
* section[0].section[0].entry[1].display = "Profile 2"

* section[0].section[0].section[0].focus = Reference(Profile2)
* section[0].section[0].section[0].entry[1] = Reference(AnotherExampleForProfile1)
* section[0].section[0].section[0].entry[1].display = "This instance is an example of Profile 1 but also of Profile 2"
* section[0].section[0].section[0].entry[2] = Reference(Extension1)  //...




// More groups
* section[0].section[1].title = "Vocabulary"
* section[0].section[0].entry[0] = Reference(CodeSystem1)
* section[0].section[0].entry[1] = Reference(CodeSystem2)
* section[0].section[0].entry[2] = Reference(Extension1)

* section[0].section[2].title = "Instances"
* section[0].section[0].entry[0] = Reference(Instance1)
* section[0].section[0].entry[1] = Reference(Instance2)


// More pages
* section[1].title = "Artifacts - By Project"
* section[1].text.div = "<div><p>This is the artifact index by project</p></div>" // or resource description
* section[1].text.status = #additional
* section[1].mode = #section  // If this is #section, a new tab will be added. in the page. If we want a new page, it's a new Composition
* section[1].section[0].title = "Project 1"
* section[1].section[0].entry[0] = Reference(Profile1)
* section[1].section[0].entry[0].display = "Profile 1"
* section[1].section[0].section[0].entry[0] = Reference(OneExampleForProfile1)
* section[1].section[0].section[0].entry[0].display = "This instance is an example of Profile 1"
* section[1].section[0].section[0].entry[1] = Reference(AnotherExampleForProfile1)
* section[1].section[0].section[0].entry[1].display = "This instance is another example of Profile 1"



////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
//// Composition 2: Le Menu
////////////////////////////////////////////////////////////////////////////
// The menu contains the menu entries - 

Instance: IGMenu
InstanceOf: Composition
Usage: #example
Description: "IG Artifact Composition"
Title:   "IG Artifact Composition"
* status = #final
* type = #ig-menu  // if this is nested inside a big Composition, we can have this as section.code - perhaps better to avoid changing the core resource
* date = "2021-01-01"
* author.identifier.value = "IHE Belgium"
* title = "Menu"
// we need to handle merging , e.g. a project sends over all their content which will be merged. This should also work with the same mechanism - a project submits only the content they want to add

* section[0].title = "TopMenu1" // besides the implicit one
* section[0].code = #artifacts // use a preferred valueset to include the existing / default menu item ids
* section[0].entry[0].reference = "page1.html"
* section[0].entry[0].display = "Page 1"
* section[0].entry[1].reference = "http://someurl.com"
* section[0].entry[1].display = "External Ref"
* section[0].entry[1].reference = "" // How to reference to the artifacts page generated before? Does the section have an id or a url?
* section[0].entry[1].display = "Artifacts - by type"
* section[0].entry[2].reference = "" 
* section[0].entry[2].display = "Artifacts - by project"
* section[0].entry[3].reference = "" 
* section[0].entry[3].display = "Artifacts - all" // etc


////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
//// Composition 3: The Table Of Contents
////////////////////////////////////////////////////////////////////////////
// The table of contents contains the pointers to the page narratives and references to generated pages

Instance: IGTOC
InstanceOf: Composition
Usage: #example
Description: "IG Artifact Composition"
Title:   "IG Artifact Composition"
// unless this Composition / section is provided, the template will automatically create a "flat" TOC with all artifacts and default pages
* status = #final
* type = #ig-toc
* date = "2021-01-01"
* author.identifier.value = "IHE Belgium"
* title = "Table of Contents"

// top of ToC does not need a description
* section[0].title = "..."  // if we want to include the narrative inline here, only xhtml is allowed, because Nattarive does not support Markdown
* section[0].text.div = "<div><p>...</p></div>"  // if we want to include the narrative inline here, only xhtml is allowed, because Nattarive does not support Markdown
* section[0].text.status = #additional
* section[0].entry[+].reference = "" // Here a reference to a resource. Could we provide 
* section[0].entry[+].type = #markdown // to support markdown or xhtml
* section[0].entry[+].display = "" // if we want we can provide more info about the content...


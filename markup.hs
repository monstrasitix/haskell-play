


main :: IO ()
main =
    print "Hello World"
    
    
{-

<style>
    paragraph {
        font: {
            family: 'sans-serif';
            color: red;
            size: 10px;
        }
        
        line-height: 1.4;
    }
    
    group {
        &[for="button"] {
            background: {
                color: orange;
                repeat: repeat;
                size: cover;
                image: url('./images/background-palette.svg');
            }
        }
    }
    
    
    icon {
        &:previous:not(:empty) { margin-left: 1em }
        &:next:not(:empty) { margin-right: 1em }
    }
</style>

<media>
    <media:query name="mobile"  trigger=[only screen max-width="400px"] />
    <media:query name="tablet"  trigger=[only screen max-width="600px"] />
    <media:query name="desktop" trigger=[only screen max-width="800px"] />
    <media:query name="wide"    trigger=[only screen max-width="1000px"] />
</media>



<view name="landing-page" size=[width="100" height="200"]>
    <accordion>
        <navigation for="accordion">
            <anchor ref="content-1">Tab 1</anchor>
            <anchor ref="content-2">Tab 2</anchor>
            <anchor ref="content-3">Tab 3</anchor>
        </navigation>

        <content id="content-1">
            <heading level="4">Heading 4</heading>
        </content>

        <content id="content-2">
            <heading level="4">Heading 4</heading>
        </content>

        <content id="content-3">
            <heading level="4">Heading 4</heading>
        </content>
    </accordion>


    <container>
        <article>
            <section>
                <heading level="1">Heading 1</heading>

                <anchor ref="#last-paragraph">Last Paragraph</anchor>

                <paragraph>
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                    Nulla porta convallis lacus, id pretium dui facilisis non.
                    Morbi sed nisi ut augue tristique mattis et nec dui.
                    Suspendisse lobortis ante nec risus ultricies, id semper orci egestas.
                    Morbi lorem ex, laoreet sit amet placerat eu, sagittis quis odio.
                    Sed vestibulum gravida volutpat. Quisque fringilla vestibulum odio
                    id ultrices. Aliquam erat volutpat. Praesent eleifend est ligula,
                    vitae placerat urna dignissim dignissim. Maecenas suscipit magna quam.
                </paragraph>

                <heading level="2">Heading 2</heading>

                <paragraph id="list-paragraph">
                    Donec tincidunt gravida massa ut ultricies. In lacinia dictum enim.
                    Etiam arcu lorem, porta nec condimentum at, convallis at risus.
                    Proin at tortor molestie, lobortis ligula ac, mattis libero.
                    Ut nec sem ac odio vehicula rhoncus sed ac ante. Nulla quis enim nisl.
                    Duis tempor, arcu sed feugiat pharetra, nisi velit sollicitudin velit,
                    at tempus purus ipsum quis sem. Integer aliquam metus consectetur vulputate posuere.
                    Vestibulum dignissim orci ut velit aliquam semper ut vel lorem.
                    Aliquam consectetur, dui sed convallis sollicitudin, mi lorem interdum mauris,
                    euismod suscipit ex neque ac mi. Aenean ullamcorper accumsan neque,
                    a iaculis dui mollis non.
                </paragraph>

                <group for="button">
                    <button>Click me</button>
                    <button>Click me</button>
                    <button>Click me</button>
                </group>
            </section>

            <section>
                <heading level="1">Form</heading>

                <form>
                    <group for="field">
                        <label>First name</label>
                        <input type="text" placeholder="Placeholder" />
                    </group>

                    <group for="field">
                        <label>Age</label>
                        <input type="number" placeholder="Placeholder" />
                    </group>

                    <group for="field">
                        <label>Gender</label>
                        <group for="radio" name="gender">
                            <radio value="0" selected>Male</radio>
                            <radio value="1">Female</radio>
                            <radio value="2">Other</radio>
                        </group>
                    </group>

                    <group for="field">
                        <label>Hobby</label>
                        <group for="checkbox" name="hobby">
                            <checkbox value="0" selected>Hiking</checkbox>
                            <checkbox value="1">Running</checkbox>
                            <checkbox value="2">Reading</checkbox>
                            <checkbox value="4">Walking</checkbox>
                            <checkbox value="5">Sleeping</checkbox>
                        </group>
                    </group>

                    <group for="button">
                        <button type="submit">Submit <icon type="paper-plane" /></button>
                        <button type="submit">Cancel <icon type="paper-plane" /></button>
                    </group>
                </form>
            </section>
        </article>
    </container>
</view>
-}

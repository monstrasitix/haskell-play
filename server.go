package main

import (
    "fmt"
    "log"
    "net/http"
    "html/template"
    
    "someone/json"
    "gorilla/mux"
)

type HandlerPage struct {
    Template string
    Payload Page
}

func (h HandlerPage) ServeHTTP(w http.ResponseWriter, r *http.Request) {
    tmpl, err = template.Files(g.Template)
    
    if err != nil {
        w.WriteHead(http.StatusInternalError)
        log.Error(err)
        return
    }
    
    w.WriteHead(http.StatusOK)
    w.Headers().Set("Content-Type", "text/html")

    tmpl.Execute(w, h.Payload)
}

type HandleJSON struct {
    Model any
}

type ORM struct {
    get
}

type Product struct {
    Id, Name string
}

func (Product) GetEntities() []Product {
    return db.query("SELECT id, name FROM products")
}

func (h HandleJSON) ServeHTTP(w http.ResponseWriter, r *http.Request) {
    switch r.Method() {
        case http.MethodGet: h.Get(w, r)
    }
}

func (h HandleJSON) Get(w http.ResponseWriter, r *http.Request) {
    model := make(h.Model)
    bytes, err := json.Marshal(model.GetEntities())
    
    if err != nil {
       w.WriteHead(http.StatusInternalError)
       log.Error(err)
       return
    }
    
    w.WriteHead(http.StatusOK)
    w.Headers().Set("Content-Type", "application/json")
    
    w.Write(bytes)
}

type Page {
    Title string
}

func main() {
    router := mux.NewRouter()
    
    router.Handle("/", HandlerPage{
        Template =  "./index.html",
        Payload = Page{
            Title = "Homepage",
        },
    }).Methods(http.MethodGet)
    
    router.Handle("/about", HandlerPage{
        Template = "./about.html",
        Payload = Page{
            Title = "About Us",
        },
    }).Methods(http.MethodGet)
    
    router.Handle("/contact", HandlerPage{
        Template = "./contact.html",
        Payload = Page{
            Title = "Contact Us",
        },
    }).Methods(http.MethodGet)
    
    api := router.SubRouter().Prefix("/api/v1")
    
    api.Handle("/products", HandleJSON{
        Model = &Product{}
    }).Methods(
        http.MethodGet,
        http.MethodPost,
        http.MethodPut,
        http.MethodPatch)
    
    server := http.Server{
        Addr = ":3000",
        Handler = router,
    }
    
    log.Fatal(server.ListenAndServe())
}

{% macro render(post, raw, is_index, post_extra_class) %}

  {% set headlessPost = Array.prototype.indexOf.call(['quote', 'picture'], post.type) > -1 %}

  {% set post_class = 'post post-type-' + post.type | default('normal') %}
  {% set post_class = post_class + ' ' + post_extra_class | default('') %}
  {% if post.sticky > 0 %}
    {% set post_class = post_class + ' ' + 'post-sticky' %}
  {% endif %}

  <article class="{{ post_class }}" itemscope itemtype="http://schema.org/Article">
  <link itemprop="mainEntityOfPage" href="{{ config.url }}{{ url_for(post.path) }}">

  <span style="display:none" itemprop="author" itemscope itemtype="http://schema.org/Person">
    <meta itemprop="name" content="{{ theme.author }}">
    <meta itemprop="description" content="{{ theme.signature }}">
    <meta itemprop="image" content="{{ url_for( theme.avatar | default(theme.images + '/avatar.gif') ) }}">
  </span>

  <span style="display:none" itemprop="publisher" itemscope itemtype="http://schema.org/Organization">
    <meta itemprop="name" content="{{ config.title }}">
    <span style="display:none" itemprop="logo" itemscope itemtype="http://schema.org/ImageObject">
      <img style="display:none;" itemprop="url image" alt="{{ config.title }}" src="{{ theme.custom_logo.image }}">
    </span>
  </span>

    {% if not headlessPost %}
      <header class="post-header">

        <div class="post-meta">


          {% if post.categories and post.categories.length and theme.post_meta.categories %}
            <span class="post-category" >
            {% if theme.post_meta.created_at or theme.post_meta.updated_at %}
              <span class="post-meta-divider">|</span>
            {% endif %}
              <span class="post-meta-item-icon">
                <i class="fa fa-folder-o"></i>
              </span>
              {% if theme.post_meta.item_text %}
                <span class="post-meta-item-text">{{ __('post.in') }}</span>
              {% endif %}
              {% for cat in post.categories %}
                <span itemprop="about" itemscope itemtype="http://schema.org/Thing">
                  <a href="{{ url_for(cat.path) }}" itemprop="url" rel="index">
                    <span itemprop="name">{{ cat.name }}</span>
                  </a>
                </span>

                {% set cat_length = post.categories.length %}
                {% if cat_length > 1 and loop.index !== cat_length %}
                  {{ __('symbol.comma') }}
                {% endif %}
              {% endfor %}
            </span>
          {% endif %}


          {% if post.description and (not theme.excerpt_description or not is_index) %}
              <div class="post-description">
                  {{ post.description }}
              </div>
          {% endif %}

        </div>
      </header>
    {% endif %}


    <div>
{{ post.raw.slice(80) }}
    </div>



    <footer class="post-footer">
      {% set isLast = loop.index % page.per_page === 0 %}
      {% if is_index and not isLast %}
        <div class="post-eof"></div>
      {% endif %}
    </footer>
  </article>

{% endmacro %}

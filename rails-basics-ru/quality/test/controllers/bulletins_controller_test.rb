require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'all bulletins page' do
    get root_url
    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  test 'open one bulletin page' do
    bulletin = Bulletin.create(title: 'XZ', body: 'Jopa')
    get bulletin_url(bulletin.id)
    assert_response :success
    assert_select 'h1', 'XZ'
    assert_select 'p', 'Jopa'
  end

  test 'open two bulletin with fixture' do
    bulletin = bulletins(:two)
    get bulletin_url(bulletin)
    assert_response :success
    assert_select 'h1', 'Title 2'
    assert_select 'p', 'Body 2'
  end
end

import Vue from 'vue'
import router from './router'
import store from './store'
import NProgress from 'nprogress' // progress bar
import 'nprogress/nprogress.css' // progress bar style
import { USER_ID,INDEX_MAIN_PAGE_PATH } from '@/store/mutation-types'
import { generateIndexRouter } from "@/utils/util"

NProgress.configure({ showSpinner: false }) // NProgress Configuration

const whiteList = ['/user/login', '/user/register', '/user/register-result'] // no redirect whitelist

router.beforeEach((to, from, next) => {
  NProgress.start() // start progress bar
  if (Vue.ls.get(USER_ID)) {
    /* has token */
    if (to.path === '/' || to.path === '/user/login') {
      next({ path: INDEX_MAIN_PAGE_PATH })
      NProgress.done()
    } else {
      if (store.getters.permissionList.length === 0) {
        store.dispatch('GetPermissionList').then(res => {
          let menuData = res;
          // 缓存用户的按钮权限
          store.dispatch('GetUserBtnList').then(res => {
            if (res && res.data) {
              Vue.ls.set('winBtnStrList', res.data.userBtn, 7 * 24 * 60 * 60 * 1000)
            }
          }).catch(() => {
            // 忽略按钮权限获取失败
          })
          let constRoutes = [];
          try {
            if (menuData && menuData.length > 0) {
              constRoutes = generateIndexRouter(menuData);
            } else {
              // 如果menuData为空，使用默认路由配置，确保能访问首页
              constRoutes = [];
            }
          } catch (e) {
            console.error('生成路由失败:', e);
            // 如果路由生成失败，使用默认路由
            constRoutes = [];
          }
          // 添加主界面路由
          store.dispatch('UpdateAppRouter',  { constRoutes }).then(() => {
            // 根据roles权限生成可访问的路由表
            // 动态添加可访问路由表
            router.addRoutes(store.getters.addRouters)
            // 直接跳转到首页，确保登录成功后能正常访问
            next({ path: '/dashboard/analysis' })
          }).catch(() => {
            // 如果更新路由失败，直接跳转到首页
            next({ path: '/dashboard/analysis' })
          })
        })
        .catch(() => {
          store.dispatch('Logout').then(() => {
            next({ path: '/user/login' })
          })
        })
      } else {
        if (to.path) {
          _hmt.push(['_trackPageview', '/#' + to.fullPath]);
        }
        next()
      }
    }
  } else {
    if (whiteList.indexOf(to.path) !== -1) {
      // 在免登录白名单，直接进入
      next()
    } else {
      next({ path: '/user/login' })
      NProgress.done() // if current page is login will not trigger afterEach hook, so manually handle it
    }
  }
})

router.afterEach(() => {
  NProgress.done() // finish progress bar
})

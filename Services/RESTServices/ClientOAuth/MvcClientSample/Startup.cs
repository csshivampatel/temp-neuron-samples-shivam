using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System.IdentityModel.Tokens.Jwt;

namespace MvcClient
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllersWithViews();

            JwtSecurityTokenHandler.DefaultMapInboundClaims = false;

            services.AddAuthentication(options =>
            {
                options.DefaultScheme = "Cookies";
                options.DefaultChallengeScheme = "oidc";
            })
            .AddCookie("Cookies")
            .AddOpenIdConnect("oidc", options =>
            {
                options.Authority = "http://cs101/authsvc";  //Your PMS machine name goes here. 

                options.ClientId = "MvcClientId";
                //options.ClientSecret = "secret";          //You don't need this for hybrid flow, you need this for authorization code flow
                //options.ResponseType = "code";            //You need this authorization code flow.
                options.ResponseType = "code id_token";

                options.RequireHttpsMetadata = false;
                options.SignedOutCallbackPath = "/LoggedOut";
                options.Scope.Add("openid");
                options.Scope.Add("CustREST");
                //options.Scope.Add("email");               //Add the scopes and claims that you want included in the token
                //options.Scope.Add("profile");             //Add the scopes and claims that you want included in the token

                options.SaveTokens = true;
            });
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
            }

            app.UseStaticFiles();

            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapDefaultControllerRoute();
                    //.RequireAuthorization();               //Use this for adding your own authorization rules based on token scopes
            });
        }
    }
}

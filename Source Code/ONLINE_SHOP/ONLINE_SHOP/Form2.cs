using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
namespace ONLINE_SHOP
{
    public partial class Form2 : Form
    {
        public string connectString;
        public string tendn;
        public string mk;
        SqlConnection conn;
        public Form2()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void Form2_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(connectString);
            conn.Open();
            label2.Text = tendn;
        
       }

        private void btnLogout_Click(object sender, EventArgs e)
        {
            conn.Close();
            Form1 f1 = new Form1();
            f1.connectString = connectString;
            this.Close();
            f1.Show();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            conn.Close();
            Form3 f3 = new Form3();
            f3.connectString = connectString;
            f3.tendn = tendn;
            f3.mk = mk;
           
            this.Hide();
            f3.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form7 f7 = new Form7();
            f7.connectString = connectString;
            f7.tendn = tendn;
            f7.mk = mk;
          
            this.Hide();
            f7.Show();
        }

        

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
    }
}

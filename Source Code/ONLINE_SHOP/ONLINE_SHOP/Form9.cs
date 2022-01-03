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
    public partial class Form9 : Form
    {
        public string connectString;
        public string madh;
        public string tendn;
        SqlConnection conn;
        public Form9()
        {
            InitializeComponent();
        }

        private void Form9_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(connectString);
            conn.Open();
            label2.Text = madh;
            string sqlexec1 = "EXEC SP_SEL_CTDH '" + madh + "'";
            SqlCommand cmd1 = new SqlCommand(sqlexec1, conn);
            cmd1.ExecuteNonQuery();
            SqlDataAdapter da = new SqlDataAdapter(cmd1);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            conn.Close();
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    string sqlexec1 = "EXEC SP_DEL_DKHP '" + mssv + "', '" + mahp + "'";
            //    SqlCommand cmd1 = new SqlCommand(sqlexec1, conn);
            //    cmd1.ExecuteNonQuery();
            //    MessageBox.Show("Xóa DKHP thành công.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            //    conn.Close();
            //    this.Close();
            //}
            //catch (SqlException error)
            //{
            //    string errorStr = error.ToString();
            //    string[] arrStr0 = errorStr.Split(':');
            //    string[] arrStr = arrStr0[1].Split('\n');
            //    MessageBox.Show(arrStr[0].ToString() + "\nXóa DKHP không thành công.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            //}
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
